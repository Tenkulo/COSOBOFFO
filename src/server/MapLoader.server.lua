--!strict
-- MapLoader.server.lua – COSOBOFFO
-- Carica e istanzia la mappa PATH A test: PizzeriaDistorta
-- Versione: 1.0 | Data: 2026-03-07
-- Nota: Le stanze sono costruite proceduralmente con parti base.
-- In produzione: caricare modelli da ServerStorage/Maps

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- ============================================================
-- DEFINIZIONE STANZE PATH A (PizzeriaDistorta)
-- Ogni stanza è una struttura con:
--   id: roomId dal RoomGraph
--   size: dimensioni (X, Y, Z)
--   color: BrickColor per prototipo visivo
--   hasObjective: bool (stanza obiettivo)
--   objectiveType: "leva" | "documento" | "simbolo"
-- ============================================================
local ROOM_DEFINITIONS = {
  entrance_pizzeria = {
    id = "entrance_pizzeria",
    size = Vector3.new(30, 8, 30),
    color = BrickColor.new("Reddish brown"),
    hasObjective = false,
    spawnPoint = Vector3.new(0, 5, 0),
    ambientDesc = "Ingresso pizzeria. Odore di plastica bruciata. Tavoli rovesciati.",
  },
  stage_corrotto = {
    id = "stage_corrotto",
    size = Vector3.new(40, 10, 35),
    color = BrickColor.new("Dark orange"),
    hasObjective = false,
    objectiveType = nil,
    ambientDesc = "Palco con animatronics fermi in pose impossibili.",
  },
  cucina_distorta = {
    id = "cucina_distorta",
    size = Vector3.new(25, 8, 25),
    color = BrickColor.new("Sand green"),
    hasObjective = true,
    objectiveType = "documento",
    ambientDesc = "Cucina industriale. Fornelli attivi senza fiamma visibile. Il piano del lavoro gronda.",
  },
  corridoio_retro = {
    id = "corridoio_retro",
    size = Vector3.new(10, 7, 50),
    color = BrickColor.new("Dark grey"),
    hasObjective = false,
    ambientDesc = "Corridoio stretto sul retro. Porte bloccate. Rumori di catene.",
  },
  ufficio_sorveglianza = {
    id = "ufficio_sorveglianza",
    size = Vector3.new(15, 8, 15),
    color = BrickColor.new("Dark red"),
    hasObjective = true,
    objectiveType = "leva",
    ambientDesc = "Ufficio del guardiano. Monitor spenti tranne uno che mostra solo statica.",
  },
  magazzino_buio = {
    id = "magazzino_buio",
    size = Vector3.new(35, 9, 35),
    color = BrickColor.new("Black"),
    hasObjective = false,
    ambientDesc = "Magazzino completamente buio. Scatole impilate formano labirinti improvvisati.",
  },
  extraction_point = {
    id = "extraction_point",
    size = Vector3.new(20, 8, 20),
    color = BrickColor.new("Bright green"),
    hasObjective = false,
    spawnPoint = Vector3.new(0, 5, 0),
    ambientDesc = "Una porta di servizio. Un raggio di luce naturale filtra da sotto.",
  },
}

-- ============================================================
-- STATO MAPPA
-- ============================================================
local loadedRooms: {[string]: Model} = {}
local mapFolder: Folder? = nil

-- ============================================================
-- COSTRUZIONE STANZA (prototipo geometrico)
-- ============================================================
local function buildRoom(roomDef: any, position: Vector3): Model
  local model = Instance.new("Model")
  model.Name = roomDef.id

  -- Floor
  local floor = Instance.new("Part")
  floor.Name = "Floor"
  floor.Size = Vector3.new(roomDef.size.X, 1, roomDef.size.Z)
  floor.Position = position + Vector3.new(0, 0, 0)
  floor.Anchored = true
  floor.BrickColor = roomDef.color
  floor.Material = Enum.Material.SmoothPlastic
  floor.Parent = model

  -- Ceiling
  local ceiling = Instance.new("Part")
  ceiling.Name = "Ceiling"
  ceiling.Size = Vector3.new(roomDef.size.X, 1, roomDef.size.Z)
  ceiling.Position = position + Vector3.new(0, roomDef.size.Y, 0)
  ceiling.Anchored = true
  ceiling.BrickColor = BrickColor.new("Medium stone grey")
  ceiling.Material = Enum.Material.SmoothPlastic
  ceiling.Transparency = 0.3
  ceiling.Parent = model

  -- Walls (4)
  local wallH = roomDef.size.Y
  local wallDefs = {
    { size = Vector3.new(1, wallH, roomDef.size.Z), offset = Vector3.new(roomDef.size.X/2, wallH/2, 0) },
    { size = Vector3.new(1, wallH, roomDef.size.Z), offset = Vector3.new(-roomDef.size.X/2, wallH/2, 0) },
    { size = Vector3.new(roomDef.size.X, wallH, 1), offset = Vector3.new(0, wallH/2, roomDef.size.Z/2) },
    { size = Vector3.new(roomDef.size.X, wallH, 1), offset = Vector3.new(0, wallH/2, -roomDef.size.Z/2) },
  }
  for i, wd in ipairs(wallDefs) do
    local wall = Instance.new("Part")
    wall.Name = "Wall" .. tostring(i)
    wall.Size = wd.size
    wall.Position = position + wd.offset
    wall.Anchored = true
    wall.BrickColor = BrickColor.new("Medium stone grey")
    wall.Material = Enum.Material.SmoothPlastic
    wall.Parent = model
  end

  -- Luce ambiente
  local light = Instance.new("Part")
  light.Name = "LightSource"
  light.Size = Vector3.new(2, 0.5, 2)
  light.Position = position + Vector3.new(0, roomDef.size.Y - 1, 0)
  light.Anchored = true
  light.CanCollide = false
  light.BrickColor = BrickColor.new("Bright yellow")
  light.Material = Enum.Material.Neon
  local pointLight = Instance.new("PointLight")
  pointLight.Brightness = roomDef.id == "magazzino_buio" and 0.5 or 3
  pointLight.Range = roomDef.id == "magazzino_buio" and 15 or 40
  pointLight.Color = Color3.fromRGB(255, 220, 150)
  pointLight.Parent = light
  light.Parent = model

  -- Obiettivo interattivo (prototipo)
  if roomDef.hasObjective then
    local objPart = Instance.new("Part")
    objPart.Name = "ObjectiveTrigger"
    objPart.Size = Vector3.new(3, 3, 3)
    objPart.Position = position + Vector3.new(3, 2, 3)
    objPart.Anchored = true
    objPart.CanCollide = false
    objPart.BrickColor = BrickColor.new("Bright yellow")
    objPart.Material = Enum.Material.Neon
    objPart.Transparency = 0.5
    -- Attributo per interazione (HUD/GameManager la leggono)
    objPart:SetAttribute("ObjectiveRoomId", roomDef.id)
    objPart:SetAttribute("ObjectiveType", roomDef.objectiveType or "generic")
    objPart:SetAttribute("IsCompleted", false)
    -- Billboard per UI test
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = false
    billboard.Parent = objPart
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "[E] Interagisci"
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 0)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = billboard
    objPart.Parent = model
  end

  -- Punto di spawn player in prima stanza
  if roomDef.spawnPoint then
    local spawnPart = Instance.new("SpawnLocation")
    spawnPart.Size = Vector3.new(4, 1, 4)
    spawnPart.Position = position + roomDef.spawnPoint
    spawnPart.Anchored = true
    spawnPart.Neutral = true
    spawnPart.AllowTeamChangeOnTouch = false
    spawnPart.Name = "SpawnPoint_" .. roomDef.id
    spawnPart.Parent = model
  end

  -- Attributo descrizione lore
  model:SetAttribute("LoreDesc", roomDef.ambientDesc or "")
  model:SetAttribute("RoomId", roomDef.id)

  return model
end

-- ============================================================
-- CARICA MAPPA PATH A (Sequenza lineare per VS test)
-- ============================================================
local function loadPathA()
  local MAP_SEQUENCE = {
    "entrance_pizzeria",
    "corridoio_retro",
    "stage_corrotto",
    "cucina_distorta",
    "magazzino_buio",
    "ufficio_sorveglianza",
    "extraction_point",
  }

  -- Crea folder mappa nel workspace
  local folder = Instance.new("Folder")
  folder.Name = "Map_PathA"
  folder.Parent = Workspace
  mapFolder = folder

  -- Posiziona stanze in sequenza lineare Z
  local currentZ = 0

  for i, roomId in ipairs(MAP_SEQUENCE) do
    local roomDef = ROOM_DEFINITIONS[roomId]
    if roomDef then
      local pos = Vector3.new(0, 1, currentZ + roomDef.size.Z / 2)
      local model = buildRoom(roomDef, pos)
      model.Parent = folder
      loadedRooms[roomId] = model

      -- Registra posizione stanza per EntitySpawner
      -- _G.RoomPositions usato da EntitySpawner per spawn accuracy
      if not _G.RoomPositions then _G.RoomPositions = {} end
      _G.RoomPositions[roomId] = pos

      currentZ += roomDef.size.Z + 5 -- 5 studs di corridoio tra stanze

      print(string.format("[MapLoader] Stanza '%s' creata @ Z=%.0f", roomId, pos.Z))
    end
  end

  print(string.format("[MapLoader] PATH A caricato: %d stanze, lunghezza totale ~%.0f studs",
    #MAP_SEQUENCE, currentZ))
end

-- ============================================================
-- CLEANUP
-- ============================================================
local function unloadMap()
  if mapFolder then
    mapFolder:Destroy()
    mapFolder = nil
  end
  loadedRooms = {}
  if _G.RoomPositions then _G.RoomPositions = {} end
  print("[MapLoader] Mappa rimossa")
end

-- ============================================================
-- API GLOBALE
-- ============================================================
_G.MapLoaderModule = {
  LoadPathA = loadPathA,
  UnloadMap = unloadMap,
  GetRoom = function(roomId: string) return loadedRooms[roomId] end,
  GetLoadedRooms = function() return loadedRooms end,
}

-- Autoload PATH A per test VS
loadPathA()

print("[MapLoader] Inizializzato. PATH A caricato e pronto.")
