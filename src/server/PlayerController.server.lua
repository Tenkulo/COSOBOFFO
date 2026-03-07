--!strict
-- PlayerController.server.lua – COSOBOFFO
-- Gestione movimento player: walk, sprint (Shift), stamina, jump con peso
-- Versione: 1.0 | Data: 2026-03-07
-- Lore: l'Archivio opprime fisicamente chi vi entra. Sprint = sforzo reale.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RemoteEvents attesi in ReplicatedStorage/Remotes/
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SprintStarted: RemoteEvent = Remotes:WaitForChild("SprintStarted") :: RemoteEvent
local SprintEnded: RemoteEvent = Remotes:WaitForChild("SprintEnded") :: RemoteEvent
local StaminaUpdate: RemoteEvent = Remotes:WaitForChild("StaminaUpdate") :: RemoteEvent
local NoiseEmitted: RemoteEvent = Remotes:WaitForChild("NoiseEmitted") :: RemoteEvent

-- ============================================================
-- CONFIGURAZIONE BASE (valori overridati da GuildLoadout.ResolveStats)
-- ============================================================
local DEFAULT_STATS = {
	walkSpeed = 14,			-- Humanoid.WalkSpeed in studs/sec
	sprintSpeed = 24,
	staminaMax = 100,
	staminaRegen = 1.2,		-- per secondo, solo fuori CHASE
	staminaDrain = 2.5,		-- per secondo durante sprint
	staminaRegenDelay = 1.5,-- secondi dopo sprint stop prima di regenrare
	jumpPower = 40,			-- Humanoid.JumpPower
	jumpNoise = 8,			-- unita' di rumore al salto (per Silenziatore AI)
	sprintNoise = 3,		-- unita' di rumore per secondo durante sprint
	walkNoise = 1,			-- unita' di rumore per secondo durante walk
}

-- ============================================================
-- STATO PER PLAYER
-- ============================================================
local playerStates: {[Player]: any} = {}

local function initPlayerState(player: Player): any
	return {
		stats = {
			walkSpeed = DEFAULT_STATS.walkSpeed,
			sprintSpeed = DEFAULT_STATS.sprintSpeed,
			staminaMax = DEFAULT_STATS.staminaMax,
			staminaRegen = DEFAULT_STATS.staminaRegen,
			staminaDrain = DEFAULT_STATS.staminaDrain,
			jumpPower = DEFAULT_STATS.jumpPower,
			jumpNoise = DEFAULT_STATS.jumpNoise,
			sprintNoise = DEFAULT_STATS.sprintNoise,
			walkNoise = DEFAULT_STATS.walkNoise,
			staminaRegenDelay = DEFAULT_STATS.staminaRegenDelay,
			noiseMult = 1.0,
		},
		stamina = DEFAULT_STATS.staminaMax,
		isSprinting = false,
		timeSinceSprintStop = 0,
		isInChase = false,	-- set da EntitySpawner quando entita' in CHASE
		noiseCooldown = 0,
	}
end

-- ============================================================
-- APPLICA STATS DA GUILDLOADOUT (chiamato da GameManager)
-- ============================================================
local function applyStats(player: Player, stats: any)
	local state = playerStates[player]
	if not state then return end

	for k, v in pairs(stats) do
		state.stats[k] = v
	end

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state.stats.walkSpeed
			hum.JumpPower = state.stats.jumpPower
		end
	end
end

-- ============================================================
-- GESTIONE SPRINT (input da client via RemoteEvent)
-- ============================================================
SprintStarted.OnServerEvent:Connect(function(player: Player)
	local state = playerStates[player]
	if not state then return end
	if state.stamina <= 0 then return end

	state.isSprinting = true
	state.timeSinceSprintStop = 0

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state.stats.sprintSpeed
		end
	end
end)

SprintEnded.OnServerEvent:Connect(function(player: Player)
	local state = playerStates[player]
	if not state then return end

	state.isSprinting = false
	state.timeSinceSprintStop = 0

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state.stats.walkSpeed
		end
	end
end)

-- ============================================================
-- GESTIONE JUMP – peso e rumore
-- ============================================================
local function onJumped(player: Player)
	local state = playerStates[player]
	if not state then return end

	-- Emit rumore: aggro entita' sonore (Silenziatore)
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local noiseAmt = state.stats.jumpNoise * state.stats.noiseMult
	NoiseEmitted:FireAllClients(hrp.Position, noiseAmt, player)

	-- Breve penalita' stamina per jump in sprint
	if state.isSprinting then
		state.stamina = math.max(0, state.stamina - 8)
		StaminaUpdate:FireClient(player, state.stamina, state.stats.staminaMax)
	end
end

-- ============================================================
-- GAME LOOP: stamina drain/regen + noise continuo
-- ============================================================
RunService.Heartbeat:Connect(function(dt: number)
	for player, state in pairs(playerStates) do
		-- Stamina drain durante sprint
		if state.isSprinting then
			state.stamina = math.max(0, state.stamina - state.stats.staminaDrain * dt)
			-- Forza stop sprint se stamina esaurita
			if state.stamina <= 0 then
				state.isSprinting = false
				state.timeSinceSprintStop = 0
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then hum.WalkSpeed = state.stats.walkSpeed end
				end
			end
		else
			-- Regen stamina (solo fuori CHASE e dopo delay)
			state.timeSinceSprintStop += dt
			if not state.isInChase and state.timeSinceSprintStop >= state.stats.staminaRegenDelay then
				state.stamina = math.min(
					state.stats.staminaMax,
					state.stamina + state.stats.staminaRegen * dt
				)
			end
		end

		-- Aggiorna HUD client ogni 0.1s
		state.noiseCooldown -= dt
		if state.noiseCooldown <= 0 then
			state.noiseCooldown = 0.1
			StaminaUpdate:FireClient(player, math.floor(state.stamina), state.stats.staminaMax)

			-- Emetti rumore passivo (walk/sprint)
			local char = player.Character
			if char then
				local hrp = char:FindFirstChild("HumanoidRootPart")
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hrp and hum and hum.MoveDirection.Magnitude > 0.1 then
					local noisePerSec = state.isSprinting and state.stats.sprintNoise or state.stats.walkNoise
					local noiseAmt = noisePerSec * state.stats.noiseMult * 0.1
					NoiseEmitted:FireAllClients(hrp.Position, noiseAmt, player)
				end
			end
		end
	end
end)

-- ============================================================
-- GESTIONE PLAYER JOIN/LEAVE
-- ============================================================
Players.PlayerAdded:Connect(function(player: Player)
	playerStates[player] = initPlayerState(player)

	player.CharacterAdded:Connect(function(char)
		local state = playerStates[player]
		if not state then return end

		local hum = char:WaitForChild("Humanoid") :: Humanoid
		hum.WalkSpeed = state.stats.walkSpeed
		hum.JumpPower = state.stats.jumpPower

		-- Collega evento jump per rumore
		hum.Jumping:Connect(function(isJumping: boolean)
			if isJumping then
				onJumped(player)
			end
		end)
	end)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	playerStates[player] = nil
end)

-- ============================================================
-- API ESTERNA (usata da GameManager)
-- ============================================================
local PlayerController = {}

function PlayerController.ApplyGuildStats(player: Player, stats: any)
	applyStats(player, stats)
end

function PlayerController.SetChaseState(player: Player, inChase: boolean)
	local state = playerStates[player]
	if state then state.isInChase = inChase end
end

function PlayerController.GetStamina(player: Player): number
	local state = playerStates[player]
	if not state then return 0 end
	return state.stamina
end

return PlayerController
