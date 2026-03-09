--!strict
-- PlayerMobility.client.lua
-- Gestione Sprint (LeftShift) con Stamina e Jump per COSOBOFFO
-- P0 Mobility Fix - 2026-03-09

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid") as Humanoid

-- Configurazione
local WALK_SPEED = 16
local SPRINT_SPEED = 28
local JUMP_POWER = 50
local STAMINA_MAX = 100
local STAMINA_DRAIN = 20 -- per secondo
local STAMINA_REGEN = 15 -- per secondo
local STAMINA_COOLDOWN = 1.5 -- tempo prima del regen

-- Stato
local currentStamina = STAMINA_MAX
local isSprinting = false
local lastSprintTime = 0

-- Inizializzazione Humanoid
humanoid.WalkSpeed = WALK_SPEED
humanoid.JumpPower = JUMP_POWER
humanoid.UseJumpPower = true

local function updateMobility(dt: number)
    if not character or not humanoid or humanoid.Health <= 0 then return end
    
    local moveDirection = humanoid.MoveDirection
    local isMoving = moveDirection.Magnitude > 0
    
    -- Sprint Logic
    if isSprinting and isMoving and currentStamina > 0 then
        humanoid.WalkSpeed = SPRINT_SPEED
        currentStamina = math.max(0, currentStamina - STAMINA_DRAIN * dt)
        lastSprintTime = os.clock()
        
        if currentStamina <= 0 then
            isSprinting = false
        end
    else
        humanoid.WalkSpeed = WALK_SPEED
        -- Regen logic
        if os.clock() - lastSprintTime > STAMINA_COOLDOWN then
            currentStamina = math.min(STAMINA_MAX, currentStamina + STAMINA_REGEN * dt)
        end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.LeftShift then
        isSprinting = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        isSprinting = false
    end
end)

RunService.Heartbeat:Connect(updateMobility)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WALK_SPEED
    currentStamina = STAMINA_MAX
end)
