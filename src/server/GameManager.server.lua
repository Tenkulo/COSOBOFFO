--!strict
-- GameManager.server.lua – COSOBOFFO
-- Orchestratore sessione: RoomGraph → spawn → obiettivi → extraction
-- Versione: 1.0 | Data: 2026-03-07
-- Fase: 3B – VS Integration (P1)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

-- Moduli shared
local RoomGraph = require(ReplicatedStorage.Modules.RoomGraph)
local GuildLoadout = require(ReplicatedStorage.Modules.GuildLoadout)
local LootTable = require(ReplicatedStorage.Modules.LootTable)

-- Remotes (creati da SetupRemotes, aspetta che siano pronti)
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
local ObjectiveUpdate: RemoteEvent = Remotes:WaitForChild("ObjectiveUpdate") :: RemoteEvent
local ExtractionReady: RemoteEvent = Remotes:WaitForChild("ExtractionReady") :: RemoteEvent

-- ============================================================
-- CONFIGURAZIONE SESSIONE
-- ============================================================
local SESSION_CONFIG = {
  defaultPath = "A",          -- PATH A: Pizzeria (test VS)
  defaultDifficulty = 2,      -- 1=easy, 2=normal, 3=hard
  defaultModifier = nil,      -- nil = nessun modifier
  extractionTime = 10,        -- secondi per completare extraction point
  sessionTimeout = 1200,      -- 20 minuti max per run
  minPlayersToStart = 1,      -- 1 per test locale
  maxPlayers = 4,
}

-- ============================================================
-- STATO SESSIONE GLOBALE
-- ============================================================
local SessionState = {
  phase = "LOBBY",            -- LOBBY → COUNTDOWN → RUNNING → EXTRACTION → ENDED
  graph = {},                 -- RoomGraph generato
  objectives = {},            -- lista roomId obiettivo
  objectivesCompleted = {},   -- roomId completati
  players = {},               -- player attivi in sessione
  entityRefs = {},            -- modelli entità spawnate
  timer = 0,
  extractionActivated = false,
  runModifier = nil,
}

-- ============================================================
-- UTILITY
-- ============================================================
local function broadcast(message: string)
  for _, player in ipairs(Players:GetPlayers()) do
    -- Semplice log via print (UI toast verrà in P2)
    print(string.format("[GM → %s] %s", player.Name, message))
  end
end

local function getAlivePlayers(): {Player}
  local alive = {}
  for _, p in ipairs(Players:GetPlayers()) do
    if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
      local hum = p.Character:FindFirstChildOfClass("Humanoid") :: Humanoid
      if hum.Health > 0 then
        table.insert(alive, p)
      end
    end
  end
  return alive
end

-- ============================================================
-- FASE: INIT SESSION
-- ============================================================
local function initSession(pathId: string?, difficulty: number?, modifierId: string?)
  local path = pathId or SESSION_CONFIG.defaultPath
  local diff = difficulty or SESSION_CONFIG.defaultDifficulty

  -- Genera grafo stanze
  SessionState.graph = RoomGraph.Generate(path, diff)
  SessionState.objectives = RoomGraph.GetObjectiveRooms(SessionState.graph)
  SessionState.objectivesCompleted = {}
  SessionState.phase = "RUNNING"
  SessionState.timer = 0
  SessionState.extractionActivated = false
  SessionState.entityRefs = {}

  -- Applica modifier run
  if modifierId then
    SessionState.runModifier = GuildLoadout.GetModifier(modifierId)
  else
    SessionState.runModifier = nil
  end

  -- Comunica grafo a EntitySpawner (via variabile condivisa nel server)
  -- EntitySpawner legge _G.CurrentGraph (pattern semplice per prototipo)
  _G.CurrentGraph = SessionState.graph
  _G.CurrentPathId = path
  _G.CurrentDifficulty = diff

  -- Applica loadout gilda a ogni player
  local EntitySpawner = _G.EntitySpawnerModule
  for _, player in ipairs(Players:GetPlayers()) do
    -- Default: ruolo Corriere se non selezionato
    local roleId = player:GetAttribute("GuildRole") or "Corriere"
    local unlockedPerks: {string} = {} -- TODO: caricare da DataStore in P2
    local stats = GuildLoadout.ResolveStats(roleId, unlockedPerks)

    -- Applica stats via PlayerController API
    local PC = _G.PlayerControllerModule
    if PC then
      PC.ApplyGuildStats(player, stats)
    end
  end

  -- Avvia EntitySpawner
  if EntitySpawner then
    EntitySpawner.SpawnForGraph(SessionState.graph, path)
  end

  -- Notifica obiettivi iniziali
  for _, player in ipairs(Players:GetPlayers()) do
    ObjectiveUpdate:FireClient(player, SessionState.objectives, SessionState.objectivesCompleted)
  end

  broadcast(string.format("[Run avviata] PATH %s | Difficoltà: %d | Stanze: %d | Obiettivi: %d",
    path, diff, #SessionState.graph, #SessionState.objectives))

  print(string.format("[GameManager] Session RUNNING – PATH %s, diff %d, %d stanze, %d obiettivi",
    path, diff, #SessionState.graph, #SessionState.objectives))
end

-- ============================================================
-- FASE: OBIETTIVO COMPLETATO
-- ============================================================
local function onObjectiveCompleted(roomId: string, player: Player)
  -- Verifica non già completato
  for _, done in ipairs(SessionState.objectivesCompleted) do
    if done == roomId then return end
  end

  table.insert(SessionState.objectivesCompleted, roomId)

  -- Loot drop
  local roleId = player:GetAttribute("GuildRole") or "Corriere"
  local role = GuildLoadout.GetRole(roleId)
  local perkBonus = role and role.guildPerkId or nil
  local loot = LootTable.Roll(perkBonus)
  if loot then
    print(string.format("[GameManager] %s ha completato obiettivo '%s' – Loot: [%s] %s",
      player.Name, roomId, loot.rarity, loot.name))
    -- TODO: award loot a player tramite DataStore in P2
  end

  -- Notifica aggiornamento obiettivi
  for _, p in ipairs(Players:GetPlayers()) do
    ObjectiveUpdate:FireClient(p, SessionState.objectives, SessionState.objectivesCompleted)
  end

  -- Controlla se tutti gli obiettivi sono completati
  if #SessionState.objectivesCompleted >= #SessionState.objectives then
    -- Attiva extraction
    SessionState.phase = "EXTRACTION"
    SessionState.extractionActivated = true
    for _, p in ipairs(Players:GetPlayers()) do
      ExtractionReady:FireClient(p)
    end
    broadcast("[Archivio] Tutti gli obiettivi completati. Punto di estrazione attivo.")
    print("[GameManager] EXTRACTION PHASE attivata")
  end
end

-- ============================================================
-- FASE: EXTRACTION
-- ============================================================
local function onExtractionComplete()
  SessionState.phase = "ENDED"

  -- Reward finale (modifier multiplier)
  local rewardMult = 1.0
  if SessionState.runModifier then
    rewardMult = SessionState.runModifier.rewardMult
  end

  local alivePlayers = getAlivePlayers()
  print(string.format("[GameManager] Run COMPLETATA – %d players vivi – reward x%.1f",
    #alivePlayers, rewardMult))

  broadcast(string.format("[Archivio] Run completata con %d superstiti. Reward x%.1f",
    #alivePlayers, rewardMult))

  -- Cleanup entità
  local EntitySpawner = _G.EntitySpawnerModule
  if EntitySpawner then
    EntitySpawner.DespawnAll()
  end

  -- Reset stato per prossima sessione
  task.delay(5, function()
    SessionState.phase = "LOBBY"
    _G.CurrentGraph = nil
    print("[GameManager] Ritorno in LOBBY")
  end)
end

-- ============================================================
-- ESPOSIZIONE API GLOBALE (per EntitySpawner e altri server scripts)
-- ============================================================
_G.GameManagerModule = {
  OnObjectiveCompleted = onObjectiveCompleted,
  OnExtractionComplete = onExtractionComplete,
  GetSessionState = function() return SessionState end,
  IsRunning = function() return SessionState.phase == "RUNNING" or SessionState.phase == "EXTRACTION" end,
}

-- ============================================================
-- AUTOSTART: avvia sessione quando i giocatori sono pronti
-- ============================================================
local function waitAndStart()
  -- Aspetta minimo 2 secondi per setup completo
  task.wait(2)

  -- Aspetta che ci siano abbastanza player
  local timeout = 30
  local elapsed = 0
  while #Players:GetPlayers() < SESSION_CONFIG.minPlayersToStart and elapsed < timeout do
    task.wait(1)
    elapsed += 1
  end

  if #Players:GetPlayers() >= SESSION_CONFIG.minPlayersToStart then
    initSession(SESSION_CONFIG.defaultPath, SESSION_CONFIG.defaultDifficulty, SESSION_CONFIG.defaultModifier)
  else
    print("[GameManager] Nessun player. Sessione non avviata.")
  end
end

-- ============================================================
-- SESSION LOOP: timeout e monitor stato
-- ============================================================
task.spawn(function()
  waitAndStart()

  while SessionState.phase == "RUNNING" or SessionState.phase == "EXTRACTION" do
    task.wait(1)
    SessionState.timer += 1

    -- Timeout sessione
    if SessionState.timer >= SESSION_CONFIG.sessionTimeout then
      broadcast("[Archivio] Tempo scaduto. La memoria si chiude.")
      SessionState.phase = "ENDED"
      local EntitySpawner = _G.EntitySpawnerModule
      if EntitySpawner then EntitySpawner.DespawnAll() end
      break
    end

    -- Controlla se tutti i player sono morti
    if SessionState.phase == "RUNNING" then
      local alive = getAlivePlayers()
      if #alive == 0 and #Players:GetPlayers() > 0 then
        broadcast("[Archivio] Tutti i Ricorrenti sono caduti.")
        SessionState.phase = "ENDED"
        local EntitySpawner = _G.EntitySpawnerModule
        if EntitySpawner then EntitySpawner.DespawnAll() end
        break
      end
    end
  end
end)

-- Listener player join durante sessione attiva
Players.PlayerAdded:Connect(function(player: Player)
  player.CharacterAdded:Connect(function()
    task.wait(1) -- aspetta spawn
    if SessionState.phase == "RUNNING" or SessionState.phase == "EXTRACTION" then
      ObjectiveUpdate:FireClient(player, SessionState.objectives, SessionState.objectivesCompleted)
      if SessionState.extractionActivated then
        ExtractionReady:FireClient(player)
      end
    end
  end)
end)

print("[GameManager] Inizializzato. Attesa giocatori...")
