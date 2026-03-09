--!strict
-- RoomGraph.lua – COSOBOFFO (Enhanced v1.3 - ProcGen 2026)
-- Generazione procedurale con Event Sockets e weighted RNG per rigiocabilita'
-- Versione: 1.3 | Data: 2026-03-09

local RoomGraph = {}
RoomGraph.__index = RoomGraph

local ROOM_TYPES = {
	-- PATH A: Pizzeria
	{ id = "A_Entry", path = "A", weight = 10, canSpawn = false, isObj = false, loot = 0, event = false },
	{ id = "A_Hall", path = "A", weight = 8, canSpawn = true, isObj = false, loot = 2, event = true },
	{ id = "A_Kitchen", path = "A", weight = 5, canSpawn = true, isObj = true, loot = 1, event = true },
	{ id = "A_Stage", path = "A", weight = 4, canSpawn = true, isObj = true, loot = 3, event = true },
	-- PATH B: Factory
	{ id = "B_Entry", path = "B", weight = 10, canSpawn = false, isObj = false, loot = 0, event = false },
	{ id = "B_Belt", path = "B", weight = 8, canSpawn = true, isObj = false, loot = 1, event = true },
	{ id = "B_Storage", path = "B", weight = 6, canSpawn = true, isObj = true, loot = 4, event = false },
	-- Special
	{ id = "Nexus", path = "X", weight = 2, canSpawn = false, isObj = false, loot = 5, event = true, isSpec = true },
}

local CONFIG = {
	minRooms = 6,
	maxRooms = 12,
	specialChance = 0.15,
}

local function weightedRandom(pool, rng)
	local total = 0
	for _, r in ipairs(pool) do total += r.weight end
	local roll = rng:NextNumber() * total
	local cur = 0
	for _, r in ipairs(pool) do
		cur += r.weight
		if roll <= cur then return r end
	end
	return pool[1]
end

function RoomGraph.Generate(pathId: string, diff: number)
	local seed = math.random(1, 999999)
	local rng = Random.new(seed)
	local count = rng:NextInteger(CONFIG.minRooms, CONFIG.maxRooms) + (diff * 2)
	
	local pool = {}
	local spec = {}
	for _, r in ipairs(ROOM_TYPES) do
		if r.path == pathId or r.path == "X" then
			if r.isSpec then table.insert(spec, r) else table.insert(pool, r) end
		end
	end

	local graph = {}
	-- Entry
	table.insert(graph, { roomId = pathId.."_Entry", isObj = false, sockets = { entity = 0, loot = 0, event = false } })

	for i = 2, count - 1 do
		local chosen = (rng:NextNumber() < CONFIG.specialChance and #spec > 0) and weightedRandom(spec, rng) or weightedRandom(pool, rng)
		table.insert(graph, {
			roomId = chosen.id,
			isObj = chosen.isObj,
			sockets = {
				entity = chosen.canSpawn and (diff > 1 and 2 or 1) or 0,
				loot = chosen.loot,
				event = chosen.event
			}
		})
	end

	-- Exit
	table.insert(graph, { roomId = "Extraction", isObj = false, sockets = { entity = 0, loot = 0, event = false }, isExit = true })
	
	return graph, seed
end

return RoomGraph
