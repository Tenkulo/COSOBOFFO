--!strict
-- PlayerController.server.lua – COSOBOFFO (Enhanced v2.0 - 2026 Standards)
-- Gestione movimento pro: walk, sprint, crouch, stamina, noise, camera immersion
-- Versione: 2.0 | Data: 2026-03-09
-- Lore: L'Archivio opprime. Ogni passo consuma, ogni respiro e' un rischio.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SprintStarted: RemoteEvent = Remotes:WaitForChild("SprintStarted")
local SprintEnded: RemoteEvent = Remotes:WaitForChild("SprintEnded")
local CrouchStarted: RemoteEvent = Remotes:WaitForChild("CrouchStarted")
local CrouchEnded: RemoteEvent = Remotes:WaitForChild("CrouchEnded")
local StaminaUpdate: RemoteEvent = Remotes:WaitForChild("StaminaUpdate")
local NoiseEmitted: RemoteEvent = Remotes:WaitForChild("NoiseEmitted")

-- ============================================================
-- CONFIGURAZIONE (2026 Standard)
-- ============================================================
local DEFAULT_STATS = {
	walkSpeed = 14,
	sprintSpeed = 24,
	crouchSpeed = 8,
	staminaMax = 100,
	staminaRegen = 1.5,
	staminaDrain = 3.0,
	staminaRegenDelay = 2.0,
	jumpPower = 42,
	jumpNoise = 12,
	sprintNoise = 5,
	walkNoise = 1.5,
	crouchNoise = 0.2,
	hipHeightStandard = 2.0,
	hipHeightCrouch = 0.8,
}

local playerStates: {[Player]: any} = {}

local function initPlayerState(player: Player)
	return {
		stats = table.clone(DEFAULT_STATS),
		stamina = DEFAULT_STATS.staminaMax,
		isSprinting = false,
		isCrouching = false,
		timeSinceSprintStop = 0,
		isInChase = false,
		noiseCooldown = 0,
	}
end

-- ============================================================
-- CORE LOGIC: MOVIMENTO & FISICA
-- ============================================================
local function updateMovement(player: Player)
	local state = playerStates[player]
	if not state then return end
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if state.isCrouching then
		hum.WalkSpeed = state.stats.crouchSpeed
		hum.HipHeight = state.stats.hipHeightCrouch
	elseif state.isSprinting and state.stamina > 0 then
		hum.WalkSpeed = state.stats.sprintSpeed
		hum.HipHeight = state.stats.hipHeightStandard
	else
		hum.WalkSpeed = state.stats.walkSpeed
		hum.HipHeight = state.stats.hipHeightStandard
	end
end

-- ============================================================
-- EVENTI SPRINT & CROUCH
-- ============================================================
SprintStarted.OnServerEvent:Connect(function(player)
	local state = playerStates[player]
	if state and state.stamina > 10 then -- Requisito minimo per sprint
		state.isSprinting = true
		state.isCrouching = false -- Sprint rompe crouch
		updateMovement(player)
	end
end)

SprintEnded.OnServerEvent:Connect(function(player)
	local state = playerStates[player]
	if state then
		state.isSprinting = false
		state.timeSinceSprintStop = 0
		updateMovement(player)
	end
end)

CrouchStarted.OnServerEvent:Connect(function(player)
	local state = playerStates[player]
	if state then
		state.isCrouching = true
		state.isSprinting = false -- Crouch rompe sprint
		updateMovement(player)
	end
end)

CrouchEnded.OnServerEvent:Connect(function(player)
	local state = playerStates[player]
	if state then
		state.isCrouching = false
		updateMovement(player)
	end
end)

-- ============================================================
-- JUMP & NOISE
-- ============================================================
local function onJumped(player: Player)
	local state = playerStates[player]
	if not state then return end
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Noise emissivo
	local noiseAmt = state.stats.jumpNoise
	NoiseEmitted:FireAllClients(hrp.Position, noiseAmt, player)

	-- Penalita' stamina
	if state.isSprinting then
		state.stamina = math.max(0, state.stamina - 10)
	else
		state.stamina = math.max(0, state.stamina - 5)
	end
end

-- ============================================================
-- HEARTBEAT / LOOP
-- ============================================================
RunService.Heartbeat:Connect(function(dt)
	for player, state in pairs(playerStates) do
		-- Stamina Drain/Regen
		if state.isSprinting then
			state.stamina = math.max(0, state.stamina - state.stats.staminaDrain * dt)
			if state.stamina <= 0 then
				state.isSprinting = false
				updateMovement(player)
			end
		else
			state.timeSinceSprintStop += dt
			if not state.isInChase and state.timeSinceSprintStop >= state.stats.staminaRegenDelay then
				state.stamina = math.min(state.stats.staminaMax, state.stamina + state.stats.staminaRegen * dt)
			end
		end

		-- Sync HUD & Passive Noise
		state.noiseCooldown -= dt
		if state.noiseCooldown <= 0 then
			state.noiseCooldown = 0.1
			StaminaUpdate:FireClient(player, state.stamina, state.stats.staminaMax)
			
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			
			if hrp and hum and hum.MoveDirection.Magnitude > 0.1 then
				local noiseBase = state.isSprinting and state.stats.sprintNoise or (state.isCrouching and state.stats.crouchNoise or state.stats.walkNoise)
				NoiseEmitted:FireAllClients(hrp.Position, noiseBase * 0.1, player)
			end
		end
	end
end)

-- JOIN / LEAVE
Players.PlayerAdded:Connect(function(p)
	playerStates[p] = initPlayerState(p)
	p.CharacterAdded:Connect(function(c)
		local hum = c:WaitForChild("Humanoid") :: Humanoid
		hum.Jumping:Connect(function(j) if j then onJumped(p) end end)
		updateMovement(p)
	end)
end)

Players.PlayerRemoving:Connect(function(p) playerStates[p] = nil end)

local PlayerController = {}
function PlayerController.ApplyStats(p, s) playerStates[p].stats = s; updateMovement(p) end
function PlayerController.SetChase(p, c) playerStates[p].isInChase = c end
return PlayerController
