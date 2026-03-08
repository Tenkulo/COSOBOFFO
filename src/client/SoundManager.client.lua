--!strict
-- SoundManager.client.lua - COSOBOFFO
-- Audio immersivo 3D e Heartbeat dinamico
-- Versione: 1.0 | Data: 2026-03-08

local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local CONFIG = {
    heartbeatId = "rbxassetid://12345678", -- Placeholder
    ambientId = "rbxassetid://87654321", -- Placeholder
    chaseMusicId = "rbxassetid://44556677", -- Placeholder
    maxHeartbeatDistance = 100,
    minHeartbeatDistance = 10,
}

local sounds = {}
local isChasing = false

local function init()
    local hb = Instance.new("Sound")
    hb.Name = "Heartbeat"
    hb.SoundId = CONFIG.heartbeatId
    hb.Looped = true
    hb.Volume = 0
    hb.Parent = SoundService
    hb:Play()
    sounds.Heartbeat = hb

    local amb = Instance.new("Sound")
    amb.Name = "Ambient"
    amb.SoundId = CONFIG.ambientId
    amb.Looped = true
    amb.Volume = 0.3
    amb.Parent = SoundService
    amb:Play()
    sounds.Ambient = amb
end

local function updateAudio(dt: number)
    if not LocalPlayer.Character then return end
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local nearestDist = CONFIG.maxHeartbeatDistance
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.Name ~= LocalPlayer.Name then
            local dist = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
            if dist < nearestDist then nearestDist = dist end
        end
    end

    local hb = sounds.Heartbeat
    if hb then
        local intensity = 1 - (nearestDist / CONFIG.maxHeartbeatDistance)
        hb.Volume = math.clamp(intensity, 0, 1)
        hb.PlaybackSpeed = 1 + (intensity * 0.5)
    end

    local amb = sounds.Ambient
    if amb then amb.Volume = isChasing and 0.1 or 0.3 end
end

Remotes:WaitForChild("EntityChaseStart").OnClientEvent:Connect(function()
    isChasing = true
end)

RunService.RenderStepped:Connect(updateAudio)

init()
