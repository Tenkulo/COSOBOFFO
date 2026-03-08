--!strict
-- Silenziatore.server.lua – COSOBOFFO
-- Entità: Tier Correttore, Cross-Path
-- Mechanic: AI Stealth basata sul suono (Noise-based)
-- Lore: Un processo dell'Archivio che "silenzia" le anomalie sonore.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StateMachine = require(ReplicatedStorage.Modules.StateMachine)

local CONFIG = {
	name = "Il Silenziatore",
	tier = "Correttore",
	moveSpeed = 18,
	patrolSpeed = 6,
	detectionRange = 15,
	hearingRange = 60,
	attackCooldown = 2,
	damage = 40,
}

local function findNearestPlayer(ent: Model, range: number): Player?
	local hrp = ent.PrimaryPart
	if not hrp then return nil end
	local nearest: Player? = nil
	local minDist = range
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character and p.Character.PrimaryPart then
			local d = (hrp.Position - p.Character.PrimaryPart.Position).Magnitude
			if d < minDist then
				minDist = d
				nearest = p
			end
		end
	end
	return nearest
end

local function moveTowards(ent: Model, target: Vector3, speed: number, dt: number)
	local hrp = ent.PrimaryPart
	if not hrp then return end
	local dir = (target - hrp.Position).Unit
	hrp.CFrame = hrp.CFrame + dir * speed * dt
	hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
end

local function createStates(entity: Model)
	local sm = StateMachine.new(entity)
	
	sm:AddState({
		Name = "IDLE",
		OnEnter = function(ent) ent.StateTime = 0 end,
		OnUpdate = function(ent, dt)
			ent.StateTime += dt
			if ent.StateTime > 3 then sm:ChangeState("PATROL") end
		end,
	})

	sm:AddState({
		Name = "PATROL",
		OnUpdate = function(ent, dt)
			local players = Players:GetPlayers()
			for _, p in ipairs(players) do
				local noise = p:GetAttribute("CurrentNoise") or 0
				if noise > 5 then
					local char = p.Character
					if char and char.PrimaryPart then
						local dist = (entity.PrimaryPart.Position - char.PrimaryPart.Position).Magnitude
						if dist < CONFIG.hearingRange then
							ent.Target = p
							sm:ChangeState("CHASE")
							return
						end
					end
				end
			end
		end,
	})

	sm:AddState({
		Name = "CHASE",
		OnEnter = function(ent)
			local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
			if Remotes then
				local EntityChaseStart = Remotes:FindFirstChild("EntityChaseStart") :: RemoteEvent
				if EntityChaseStart then EntityChaseStart:FireAllClients(ent, CONFIG.name) end
			end
		end,
		OnUpdate = function(ent, dt)
			local target = ent.Target
			if target and target.Character and target.Character.PrimaryPart then
				moveTowards(ent, target.Character.PrimaryPart.Position, CONFIG.moveSpeed, dt)
				if (entity.PrimaryPart.Position - target.Character.PrimaryPart.Position).Magnitude < 5 then
					sm:ChangeState("ATTACK")
				end
			else
				sm:ChangeState("PATROL")
			end
		end,
	})

	sm:AddState({
		Name = "ATTACK",
		OnEnter = function(ent)
			ent.AttackTime = 0
			if ent.Target and ent.Target.Character then
				local hum = ent.Target.Character:FindFirstChildOfClass("Humanoid")
				if hum then hum:TakeDamage(CONFIG.damage) end
			end
		end,
		OnUpdate = function(ent, dt)
			ent.AttackTime += dt
			if ent.AttackTime > CONFIG.attackCooldown then sm:ChangeState("CHASE") end
		end,
	})

	sm:ChangeState("IDLE")
	return sm
end

return {
	CONFIG = CONFIG,
	CreateStateMachine = createStates,
}
