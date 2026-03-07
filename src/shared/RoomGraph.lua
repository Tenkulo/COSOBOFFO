--!strict
-- RoomGraph.lua – COSOBOFFO
-- Generazione procedurale del grafo stanze per istanze Chase/Story
-- Versione: 1.0 | Data: 2026-03-07
-- Coerenza lore: ogni nodo rappresenta una Memoria dell'Archivio

local RoomGraph = {}
RoomGraph.__index = RoomGraph

-- ============================================================
-- TIPI DI STANZA (coerenti con PATH A-E del GDD)
-- ============================================================
local ROOM_TYPES = {
	-- PATH A: Pizzeria della Memoria (FNaF)
	{ id = "entrance_pizzeria",		path = "A", weight = 10, canSpawnEntity = false, isObjective = false },
	{ id = "stage_corrotto",			path = "A", weight = 8,	canSpawnEntity = true,	isObjective = false },
	{ id = "cucina_distorta",			path = "A", weight = 7,	canSpawnEntity = true,	isObjective = true },
	{ id = "corridoio_retro",			path = "A", weight = 9,	canSpawnEntity = true,	isObjective = false },
	{ id = "ufficio_sorveglianza",		path = "A", weight = 5,	canSpawnEntity = false, isObjective = true },
	{ id = "magazzino_buio",			path = "A", weight = 6,	canSpawnEntity = true,	isObjective = false },
	-- PATH B: Fabbrica degli Scarti (Poppy)
	{ id = "nastro_trasportatore",		path = "B", weight = 8,	canSpawnEntity = true,	isObjective = false },
	{ id = "sala_generatori",			path = "B", weight = 6,	canSpawnEntity = false, isObjective = true },
	{ id = "playcare_distorto",			path = "B", weight = 5,	canSpawnEntity = true,	isObjective = false },
	-- PATH C: Siti Dimenticati (SCP)
	{ id = "corridoio_cemento",			path = "C", weight = 9,	canSpawnEntity = true,	isObjective = false },
	{ id = "cella_contenimento",			path = "C", weight = 7,	canSpawnEntity = true,	isObjective = true },
	{ id = "sala_monitor_scp",			path = "C", weight = 5,	canSpawnEntity = false, isObjective = true },
	-- PATH D: Backrooms/Liminal
	{ id = "corridoio_scolastico",		path = "D", weight = 9,	canSpawnEntity = true,	isObjective = false },
	{ id = "piscina_vuota",				path = "D", weight = 6,	canSpawnEntity = true,	isObjective = false },
	{ id = "uffici_senza_finestre",		path = "D", weight = 7,	canSpawnEntity = true,	isObjective = false },
	-- PATH E: Trasmissione Distorta (Analog Horror)
	{ id = "sala_controllo",				path = "E", weight = 7,	canSpawnEntity = true,	isObjective = false },
	{ id = "studio_tv_abbandonato",		path = "E", weight = 6,	canSpawnEntity = true,	isObjective = true },
	{ id = "bunker_monitor",				path = "E", weight = 5,	canSpawnEntity = false, isObjective = true },
	-- Stanze speciali (ogni path)
	{ id = "nexus_archivio",				path = "X", weight = 2,	canSpawnEntity = false, isObjective = false, isSpecial = true },
	{ id = "stanza_rituale",				path = "X", weight = 1,	canSpawnEntity = true,	isObjective = false, isSpecial = true },
	{ id = "extraction_point",			path = "X", weight = 0,	canSpawnEntity = false, isObjective = false, isExit = true },
}

-- ============================================================
-- CONFIGURAZIONE GRAFO
-- ============================================================
local CONFIG = {
	minRooms = 5,
	maxRooms = 9,
	minObjectiveRooms = 2,
	specialRoomChance = 0.12, -- 12% per run di avere nexus/stanza_rituale
	seed = nil, -- nil = random ogni run
	blacklistSize = 3, -- ultime N sequenze evitate
}

-- ============================================================
-- STATO INTERNO
-- ============================================================
local recentSeeds: {number} = {}

-- ============================================================
-- UTILITY
-- ============================================================
local function weightedRandom(pool: {any}, rng: Random): any
	local totalWeight = 0
	for _, item in ipairs(pool) do
		totalWeight += (item.weight or 1)
	end
	local roll = rng:NextNumber() * totalWeight
	local cumulative = 0
	for _, item in ipairs(pool) do
		cumulative += (item.weight or 1)
		if roll <= cumulative then
			return item
		end
	end
	return pool[#pool]
end

local function getUniqueSeq(seed: number): boolean
	for _, s in ipairs(recentSeeds) do
		if s == seed then return false end
	end
	return true
end

-- ============================================================
-- GENERAZIONE GRAFO
-- ============================================================
function RoomGraph.Generate(pathId: string, difficulty: number?): {any}
	-- difficulty 1=easy, 2=normal, 3=hard
	local diff = difficulty or 2

	-- Genera seed unico (anti-ripetizione)
	local seed: number
	repeat
		seed = math.floor(os.clock() * 1000) + math.random(1, 99999)
	until getUniqueSeq(seed)

	-- Mantieni blacklist dimensione CONFIG.blacklistSize
	table.insert(recentSeeds, seed)
	if #recentSeeds > CONFIG.blacklistSize then
		table.remove(recentSeeds, 1)
	end

	local rng = Random.new(seed)

	-- Filtra stanze per path (includi path X = speciali)
	local availableRooms: {any} = {}
	for _, room in ipairs(ROOM_TYPES) do
		if room.path == pathId or room.path == "X" then
			if not room.isExit then
				table.insert(availableRooms, room)
			end
		end
	end

	-- Numero stanze basato su difficoltà
	local roomCount = CONFIG.minRooms + math.floor(rng:NextNumber() * (CONFIG.maxRooms - CONFIG.minRooms))
	if diff == 3 then roomCount = roomCount + 2 end
	if diff == 1 then roomCount = math.max(CONFIG.minRooms, roomCount - 1) end

	-- Costruisci catena di nodi
	local graph: {any} = {}
	local objectiveCount = 0
	local usedSpecial = false

	-- Prima stanza: sempre entrance
	for _, room in ipairs(availableRooms) do
		if string.find(room.id, "entrance") or string.find(room.id, "corridoio") then
			table.insert(graph, {
				roomId = room.id,
				isObjective = false,
				canSpawnEntity = false,
				spawnSlots = 0,
				index = 1
			})
			break
		end
	end
	if #graph == 0 then
		table.insert(graph, { roomId = availableRooms[1].id, isObjective = false, canSpawnEntity = false, spawnSlots = 0, index = 1 })
	end

	-- Stanze mid
	local midPool: {any} = {}
	for _, room in ipairs(availableRooms) do
		if not room.isSpecial and not string.find(room.id, "entrance") then
			table.insert(midPool, room)
		end
	end

	for i = 2, roomCount do
		-- Ogni ~7 stanze: chance stanza speciale
		if not usedSpecial and rng:NextNumber() < CONFIG.specialRoomChance then
			local specialPool: {any} = {}
			for _, room in ipairs(availableRooms) do
				if room.isSpecial then
					table.insert(specialPool, room)
				end
			end
			if #specialPool > 0 then
				local chosen = weightedRandom(specialPool, rng)
				table.insert(graph, {
					roomId = chosen.id,
					isObjective = false,
					canSpawnEntity = chosen.canSpawnEntity,
					spawnSlots = chosen.canSpawnEntity and 1 or 0,
					index = i
				})
				usedSpecial = true
				continue
			end
		end

		local chosen = weightedRandom(midPool, rng)
		local isObj = chosen.isObjective and (objectiveCount < CONFIG.minObjectiveRooms)
		if isObj then objectiveCount += 1 end

		-- Spawn slots: aumentano con difficoltà
		local slots = 0
		if chosen.canSpawnEntity then
			slots = 1 + (diff - 1)
		end

		table.insert(graph, {
			roomId = chosen.id,
			isObjective = isObj,
			canSpawnEntity = chosen.canSpawnEntity,
			spawnSlots = slots,
			index = i
		})
	end

	-- Ultima stanza: extraction
	table.insert(graph, {
		roomId = "extraction_point",
		isObjective = false,
		canSpawnEntity = false,
		spawnSlots = 0,
		index = #graph + 1,
		isExit = true
	})

	-- Garantisce min obiettivi
	if objectiveCount < CONFIG.minObjectiveRooms then
		for _, node in ipairs(graph) do
			if not node.isObjective and node.canSpawnEntity and objectiveCount < CONFIG.minObjectiveRooms then
				node.isObjective = true
				objectiveCount += 1
			end
		end
	end

	return graph
end

-- Ritorna lista IDs obiettivo dal grafo generato
function RoomGraph.GetObjectiveRooms(graph: {any}): {string}
	local objectives: {string} = {}
	for _, node in ipairs(graph) do
		if node.isObjective then
			table.insert(objectives, node.roomId)
		end
	end
	return objectives
end

return RoomGraph
