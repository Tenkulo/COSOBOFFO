--!strict
-- EntitySpawner.server.lua – COSOBOFFO
-- Legge RoomGraph, spawna entità, imposta waypoints, gestisce despawn
-- Versione: 1.0 | Data: 2026-03-07
-- Pattern: clona template da ServerStorage/Entities, usa StateMachine da CorrettoreMeccanico

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
local EntityChaseStart: RemoteEvent = Remotes:WaitForChild("EntityChaseStart") :: RemoteEvent

-- ============================================================
-- CONFIGURAZIONE SPAWN
-- ============================================================
local ENTITY_CONFIG = {
  -- PATH A (Pizzeria)
  ["A"] = {
    { templateName = "CorrettoreMeccanico", spawnChance = 0.8, tier = "Correttore" },
  },
  -- PATH B (Fabbrica)
  ["B"] = {
    { templateName = "CorrettoreMeccanico", spawnChance = 0.7, tier = "Correttore" },
  },
  -- PATH C-E: fallback CorrettoreMeccanico finché altri non implementati
  ["C"] = { { templateName = "CorrettoreMeccanico", spawnChance = 0.6, tier = "Correttore" } },
  ["D"] = { { templateName = "CorrettoreMeccanico", spawnChance = 0.6, tier = "Correttore" } },
  ["E"] = { { templateName = "CorrettoreMeccanico", spawnChance = 0.6, tier = "Correttore" } },
}

-- Waypoints hardcoded per test VS (PATH A – PizzeriaDistorta)
-- Sostituire con lookup in ServerStorage/Maps/PathA/Waypoints in P2
local DEFAULT_WAYPOINTS_PATH_A: {Vector3} = {
  Vector3.new(0, 3, -10),
  Vector3.new(10, 3, -10),
  Vector3.new(10, 3, 10),
  Vector3.new(0, 3, 10),
  Vector3.new(-10, 3, 10),
  Vector3.new(-10, 3, -10),
}

local PATH_WAYPOINTS: {[string]: {Vector3}} = {
  ["A"] = DEFAULT_WAYPOINTS_PATH_A,
  ["B"] = { Vector3.new(5, 3, 0), Vector3.new(-5, 3, 0), Vector3.new(0, 3, 10) },
  ["C"] = { Vector3.new(0, 3, 0), Vector3.new(15, 3, 0), Vector3.new(15, 3, 15) },
  ["D"] = { Vector3.new(-5, 3, -5), Vector3.new(5, 3, -5), Vector3.new(5, 3, 5) },
  ["E"] = { Vector3.new(0, 3, -15), Vector3.new(10, 3, -15), Vector3.new(10, 3, 0) },
}

-- ============================================================
-- STATO SPAWNER
-- ============================================================
local spawnedEntities: {Model} = {}
local entityStateMachines: {[Model]: any} = {}

-- ============================================================
-- UTILITY: TROVA TEMPLATE ENTITÀ
-- ============================================================
local function getEntityTemplate(name: string): Model?
  local entitiesFolder = ServerStorage:FindFirstChild("Entities")
  if not entitiesFolder then
    warn("[EntitySpawner] ServerStorage/Entities folder non trovata")
    return nil
  end
  local template = entitiesFolder:FindFirstChild(name)
  if not template then
    warn(string.format("[EntitySpawner] Template '%s' non trovato in ServerStorage/Entities", name))
    return nil
  end
  return template :: Model
end

-- ============================================================
-- UTILITY: CALCOLA POSIZIONE SPAWN
-- ============================================================
local function getSpawnPosition(roomIndex: number, pathId: string): Vector3
  -- Genera posizione basata su indice stanza
  -- Layout test: stanze in linea Z+ con offset X randomico
  local baseZ = roomIndex * 25
  local offsetX = (roomIndex % 2 == 0) and 8 or -8
  return Vector3.new(offsetX, 3, baseZ)
end

-- ============================================================
-- SPAWN SINGOLA ENTITÀ
-- ============================================================
local function spawnEntity(
  templateName: string,
  position: Vector3,
  waypoints: {Vector3},
  roomId: string
): Model?
  local template = getEntityTemplate(templateName)
  if not template then
    -- Crea entità placeholder per test senza assets
    local placeholder = Instance.new("Model")
    placeholder.Name = templateName

    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 5, 2)
    hrp.Position = position
    hrp.BrickColor = BrickColor.new("Really red")
    hrp.Anchored = false
    hrp.Parent = placeholder

    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = placeholder

    placeholder.PrimaryPart = hrp
    placeholder.Parent = workspace

    template = placeholder
  else
    local clone = template:Clone()
    clone.Name = templateName .. "_" .. tostring(#spawnedEntities + 1)
    if clone.PrimaryPart then
      clone:SetPrimaryPartCFrame(CFrame.new(position))
    end
    clone.Parent = workspace
    template = clone
  end

  -- Imposta attributi
  template:SetAttribute("RoomId", roomId)
  template:SetAttribute("IsAlive", true)

  -- Imposta waypoints in CONFIG via attributo (letto da CorrettoreMeccanico)
  -- Pattern: array waypoints serializzato come attributi WP_1, WP_2, etc.
  for i, wp in ipairs(waypoints) do
    template:SetAttribute("WP_" .. tostring(i), wp)
    template:SetAttribute("WP_Count", i)
  end

  table.insert(spawnedEntities, template)

  print(string.format("[EntitySpawner] Spawned '%s' @ %s (room: %s)",
    templateName, tostring(position), roomId))

  return template
end

-- ============================================================
-- SPAWN PER GRAFO COMPLETO
-- ============================================================
local function spawnForGraph(graph: {any}, pathId: string)
  local entityList = ENTITY_CONFIG[pathId] or ENTITY_CONFIG["A"]
  local waypoints = PATH_WAYPOINTS[pathId] or DEFAULT_WAYPOINTS_PATH_A

  local totalSpawned = 0

  for _, node in ipairs(graph) do
    if node.canSpawnEntity and node.spawnSlots > 0 then
      for slot = 1, node.spawnSlots do
        -- Scegli entità casuale dalla lista del path
        local rng = Random.new()
        local entityDef = entityList[rng:NextInteger(1, #entityList)]

        -- Controlla chance spawn
        if rng:NextNumber() <= entityDef.spawnChance then
          local pos = getSpawnPosition(node.index, pathId)
          -- Offset per slot multipli nella stessa stanza
          pos = pos + Vector3.new((slot - 1) * 5, 0, 0)

          spawnEntity(entityDef.templateName, pos, waypoints, node.roomId)
          totalSpawned += 1
        end
      end
    end
  end

  print(string.format("[EntitySpawner] PATH %s: %d entità spawnate da %d stanze con slot",
    pathId, totalSpawned, #graph))
end

-- ============================================================
-- DESPAWN TUTTE LE ENTITÀ
-- ============================================================
local function despawnAll()
  for _, entity in ipairs(spawnedEntities) do
    if entity and entity.Parent then
      entity:Destroy()
    end
  end
  spawnedEntities = {}
  entityStateMachines = {}
  print("[EntitySpawner] Tutte le entità rimosse")
end

-- ============================================================
-- DEATH HANDLING: quando entità muore (future use)
-- ============================================================
local function onEntityDied(entity: Model)
  entity:SetAttribute("IsAlive", false)
  print(string.format("[EntitySpawner] Entità '%s' eliminata", entity.Name))
  -- Rimuovi dalla lista attiva
  for i, e in ipairs(spawnedEntities) do
    if e == entity then
      table.remove(spawnedEntities, i)
      break
    end
  end
end

-- ============================================================
-- ESPOSIZIONE API GLOBALE (usata da GameManager)
-- ============================================================
_G.EntitySpawnerModule = {
  SpawnForGraph = spawnForGraph,
  DespawnAll = despawnAll,
  GetActiveEntities = function() return spawnedEntities end,
  GetEntityCount = function() return #spawnedEntities end,
}

print("[EntitySpawner] Inizializzato. Pronto per SpawnForGraph.")
