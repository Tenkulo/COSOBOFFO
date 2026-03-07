--!strict
-- CorrettoreMeccanico.server.lua – COSOBOFFO
-- Entità: Tier Correttore, PATH A (Pizzeria)
-- Versione: 1.0 | Data: 2026-03-07
-- Mechanic: CHASE aggressivo, glitch visivo, look-away non immune
-- Lore: Correttore che riteneva un compito ancora valido. Ora distorce la verità.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StateMachine = require(ReplicatedStorage.Modules.StateMachine)

local CONFIG = {
	name = "Correttore Meccanico",
	tier = "Correttore",
	moveSpeed = 12,				-- studs/sec in CHASE
	patrolSpeed = 4,
	detectionRange = 30,		-- studs sight
	hearingRange = 20,			-- studs rumore
	lookAwayImmune = false,		-- bloccabile con look-away
	coreSound = "rbxassetid://1234567",	-- placeholder
	attackCooldown = 3,			-- secondi tra attacchi
	damage = 20,
	glitchRange = 15,			-- distanza glitch visivo (client side)
	patrolWaypoints = {},		-- set da EntitySpawner
}

-- ============================================================
-- STATI AI
-- ============================================================
local function createStates(entity: Model)
	local sm = StateMachine.new(entity)

	-- IDLE
	sm:AddState({
		Name = "IDLE",
		OnEnter = function(ent: any)
			-- Stop movement
			local hrp: BasePart = ent:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Anchored = true end
		end,
		OnUpdate = function(ent: any, dt: number)
			-- Transition to PATROL dopo 2s
			if not ent.StateTime then ent.StateTime = 0 end
			ent.StateTime += dt
			if ent.StateTime > 2 then
				sm:ChangeState("PATROL")
			end
		end,
		OnExit = function(ent: any)
			ent.StateTime = nil
		end,
	})

	-- PATROL
	sm:AddState({
		Name = "PATROL",
		OnEnter = function(ent: any)
			ent.WaypointIndex = 1
			local hrp: BasePart = ent:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Anchored = false end
		end,
		OnUpdate = function(ent: any, dt: number)
			-- Cerca player in range
			local target = findNearestPlayer(ent, CONFIG.detectionRange)
			if target then
				ent.Target = target
				sm:ChangeState("ALERT")
				return
			end

			-- Move to waypoint
			if #CONFIG.patrolWaypoints > 0 then
				local waypoint = CONFIG.patrolWaypoints[ent.WaypointIndex]
				moveTowards(ent, waypoint, CONFIG.patrolSpeed, dt)
				if reachedPoint(ent, waypoint) then
					ent.WaypointIndex = (ent.WaypointIndex % #CONFIG.patrolWaypoints) + 1
				end
			end
		end,
		OnExit = function(ent: any) end,
	})

	-- ALERT
	sm:AddState({
		Name = "ALERT",
		OnEnter = function(ent: any)
			ent.AlertTime = 0
		end,
		OnUpdate = function(ent: any, dt: number)
			ent.AlertTime += dt
			-- Dopo 1s: inizio CHASE
			if ent.AlertTime > 1 then
				sm:ChangeState("CHASE")
			end
		end,
		OnExit = function(ent: any) end,
	})

	-- CHASE
	sm:AddState({
		Name = "CHASE",
		OnEnter = function(ent: any)
			-- Notify players: glitch visivo, heartbeat
			local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
			if Remotes then
				local EntityChaseStart: RemoteEvent = Remotes:FindFirstChild("EntityChaseStart")
				if EntityChaseStart then
					EntityChaseStart:FireAllClients(ent, CONFIG.name)
				end
			end
		end,
		OnUpdate = function(ent: any, dt: number)
			-- Look-away check
			if not CONFIG.lookAwayImmune and isPlayerLookingAt(ent, ent.Target) then
				-- Stop chase, back to ALERT
				sm:ChangeState("ALERT")
				return
			end

			-- Move towards target
			local target = ent.Target
			if target and target.Character then
				local tPos = target.Character:FindFirstChild("HumanoidRootPart")
				if tPos then
					moveTowards(ent, tPos.Position, CONFIG.moveSpeed, dt)
					-- Range attack
					if (ent:FindFirstChild("HumanoidRootPart").Position - tPos.Position).Magnitude < 5 then
						sm:ChangeState("ATTACK")
					end
				end
			else
				-- Lost target
				sm:ChangeState("PATROL")
			end
		end,
		OnExit = function(ent: any) end,
	})

	-- ATTACK
	sm:AddState({
		Name = "ATTACK",
		OnEnter = function(ent: any)
			ent.AttackTime = 0
			-- Deal damage
			local target = ent.Target
			if target and target.Character then
				local hum = target.Character:FindFirstChildOfClass("Humanoid")
				if hum then
					hum:TakeDamage(CONFIG.damage)
				end
			end
		end,
		OnUpdate = function(ent: any, dt: number)
			ent.AttackTime += dt
			if ent.AttackTime > CONFIG.attackCooldown then
				sm:ChangeState("CHASE")
			end
		end,
		OnExit = function(ent: any) end,
	})

	sm:ChangeState("IDLE")
	return sm
end

-- ============================================================
-- UTILITY FUNCTIONS
-- ============================================================
function findNearestPlayer(ent: Model, range: number): Player?
	local hrp: BasePart? = ent:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end

	local nearest: Player? = nil
	local minDist = range
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			local pHrp = p.Character:FindFirstChild("HumanoidRootPart")
			if pHrp then
				local d = (hrp.Position - pHrp.Position).Magnitude
				if d < minDist then
					minDist = d
					nearest = p
				end
			end
		end
	end
	return nearest
end

function moveTowards(ent: Model, target: Vector3, speed: number, dt: number)
	local hrp: BasePart? = ent:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local dir = (target - hrp.Position).Unit
	hrp.CFrame = hrp.CFrame + dir * speed * dt
	hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
end

function reachedPoint(ent: Model, target: Vector3): boolean
	local hrp: BasePart? = ent:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	return (hrp.Position - target).Magnitude < 3
end

function isPlayerLookingAt(ent: Model, player: Player): boolean
	-- Simplified look-away: check se player camera punta verso entita'
	if not player.Character then return false end
	local cam = workspace.CurrentCamera
	if not cam then return false end

	local entHrp: BasePart? = ent:FindFirstChild("HumanoidRootPart")
	if not entHrp then return false end

	local camDir = cam.CFrame.LookVector
	local toEnt = (entHrp.Position - cam.CFrame.Position).Unit
	local dot = camDir:Dot(toEnt)
	return dot > 0.7 -- entro ~45 gradi
end

-- ============================================================
-- EXPORT
-- ============================================================
return {
	CONFIG = CONFIG,
	CreateStateMachine = createStates,
}
