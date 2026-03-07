--!strict
-- SetupRemotes.server.lua – COSOBOFFO
-- Crea folder Remotes in ReplicatedStorage con tutti i RemoteEvents richiesti
-- Deve essere il PRIMO script a girare (ServerScriptService, esecuzione immediata)
-- Versione: 1.0 | Data: 2026-03-07

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================================
-- REMOTE EVENTS RICHIESTI DAI MODULI
-- ============================================================
local REMOTE_EVENTS = {
  -- PlayerController.server.lua
  "SprintStarted",
  "SprintEnded",
  "StaminaUpdate",
  "NoiseEmitted",
  -- CorrettoreMeccanico / EntitySpawner
  "EntityChaseStart",
  -- GameManager / HUD
  "ObjectiveUpdate",
  "ExtractionReady",
}

-- ============================================================
-- REMOTE FUNCTIONS RICHIESTE
-- ============================================================
local REMOTE_FUNCTIONS = {
  -- (reserved per future use)
}

-- ============================================================
-- SETUP
-- ============================================================
local function setupRemotes()
  -- Crea o trova folder Remotes
  local remotes = ReplicatedStorage:FindFirstChild("Remotes")
  if not remotes then
    remotes = Instance.new("Folder")
    remotes.Name = "Remotes"
    remotes.Parent = ReplicatedStorage
  end

  -- Crea RemoteEvents
  for _, name in ipairs(REMOTE_EVENTS) do
    if not remotes:FindFirstChild(name) then
      local re = Instance.new("RemoteEvent")
      re.Name = name
      re.Parent = remotes
    end
  end

  -- Crea RemoteFunctions
  for _, name in ipairs(REMOTE_FUNCTIONS) do
    if not remotes:FindFirstChild(name) then
      local rf = Instance.new("RemoteFunction")
      rf.Name = name
      rf.Parent = remotes
    end
  end

  -- Crea folder Modules in ReplicatedStorage (per StateMachine, etc.)
  local modules = ReplicatedStorage:FindFirstChild("Modules")
  if not modules then
    modules = Instance.new("Folder")
    modules.Name = "Modules"
    modules.Parent = ReplicatedStorage
  end

  print("[SetupRemotes] RemoteEvents pronti:", #REMOTE_EVENTS)
end

setupRemotes()
