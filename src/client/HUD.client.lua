--!strict
-- HUD.client.lua – COSOBOFFO
-- HUD minimale: stamina bar, obiettivi, heartbeat dinamico, vignettatura
-- Versione: 1.0 | Data: 2026-03-07
-- HUD-less dove possibile (audio/visual invece di numeri)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- RemoteEvents
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local StaminaUpdate: RemoteEvent = Remotes:WaitForChild("StaminaUpdate")
local EntityChaseStart: RemoteEvent = Remotes:WaitForChild("EntityChaseStart")
local ObjectiveUpdate: RemoteEvent = Remotes:WaitForChild("ObjectiveUpdate")

-- ============================================================
-- UI SETUP
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "COSOBOFFO_HUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Stamina bar (bottom center)
local staminaFrame = Instance.new("Frame")
staminaFrame.Name = "StaminaFrame"
staminaFrame.Size = UDim2.new(0.25, 0, 0.015, 0)
staminaFrame.Position = UDim2.new(0.375, 0, 0.95, 0)
staminaFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
staminaFrame.BorderSizePixel = 0
staminaFrame.Parent = screenGui

local staminaBar = Instance.new("Frame")
staminaBar.Name = "Bar"
staminaBar.Size = UDim2.new(1, 0, 1, 0)
staminaBar.BackgroundColor3 = Color3.fromRGB(80, 200, 240)
staminaBar.BorderSizePixel = 0
staminaBar.Parent = staminaFrame

-- Obiettivi (top left)
local objectivesLabel = Instance.new("TextLabel")
objectivesLabel.Name = "Objectives"
objectivesLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
objectivesLabel.Position = UDim2.new(0.02, 0, 0.02, 0)
objectivesLabel.BackgroundTransparency = 0.5
objectivesLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
objectivesLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
objectivesLabel.TextScaled = true
objectivesLabel.Font = Enum.Font.SourceSansBold
objectivesLabel.Text = "Obiettivi: 0/0"
objectivesLabel.TextXAlignment = Enum.TextXAlignment.Left
objectivesLabel.Parent = screenGui

-- Vignettatura (fullscreen, invisible di default)
local vignette = Instance.new("ImageLabel")
vignette.Name = "Vignette"
vignette.Size = UDim2.new(1, 0, 1, 0)
vignette.Position = UDim2.new(0, 0, 0, 0)
vignette.BackgroundTransparency = 1
vignette.Image = "rbxassetid://1234567" -- placeholder vignette texture
vignette.ImageTransparency = 1
vignette.ZIndex = 10
vignette.Parent = screenGui

-- ============================================================
-- STATO
-- ============================================================
local currentStamina = 100
local maxStamina = 100
local objectivesCompleted = 0
local objectivesTotal = 0
local inChase = false
local heartbeatVolume = 0

-- ============================================================
-- AGGIORNAMENTI REMOTI
-- ============================================================

StaminaUpdate.OnClientEvent:Connect(function(stamina: number, maxStam: number)
	currentStamina = stamina
	maxStamina = maxStam
	local pct = currentStamina / maxStamina
	staminaBar:TweenSize(UDim2.new(pct, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)

	-- Colore barra: verde → giallo → rosso
	if pct > 0.5 then
		staminaBar.BackgroundColor3 = Color3.fromRGB(80, 200, 240) -- azzurro
	elseif pct > 0.25 then
		staminaBar.BackgroundColor3 = Color3.fromRGB(220, 180, 60) -- giallo
	else
		staminaBar.BackgroundColor3 = Color3.fromRGB(220, 60, 60) -- rosso
	end
end)

EntityChaseStart.OnClientEvent:Connect(function(entity: Model, entityName: string)
	inChase = true
	-- Avvia effetti chase: vignette fade in, heartbeat piu' forte
	local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local goal = { ImageTransparency = 0.3 }
	TweenService:Create(vignette, tweenInfo, goal):Play()
	heartbeatVolume = 0.7

	-- Effetto screen shake simulato con leggero distorsione
	-- (opzionale: implementare shake con Camera.CFrame offset)
end)

ObjectiveUpdate.OnClientEvent:Connect(function(completed: number, total: number)
	objectivesCompleted = completed
	objectivesTotal = total
	objectivesLabel.Text = string.format("Obiettivi: %d/%d", completed, total)

	-- Se completati tutti: feedback visivo
	if completed >= total then
		objectivesLabel.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	end
end)

-- ============================================================
-- HEARTBEAT DIEGETICO (audio-driven, senza numeri)
-- ============================================================
-- Placeholder: nella versione finale, collegato a SoundManager che
-- gestisce il suono del battito cardiaco basato su:
-- - vicinanza entita'
-- - stato chase
-- - stamina bassa

-- Esempio: ogni N secondi, se inChase, aumenta volume heartbeat
spawn(function()
	while true do
		wait(1)
		if inChase then
			-- SoundManager gestirà il playback del battito
			-- qui solo aggiorniamo stato
			heartbeatVolume = math.min(1.0, heartbeatVolume + 0.05)
		else
			heartbeatVolume = math.max(0, heartbeatVolume - 0.1)
			-- Rimuovi vignette se chase finito
			if heartbeatVolume == 0 then
				inChase = false
				local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local goal = { ImageTransparency = 1 }
				TweenService:Create(vignette, tweenInfo, goal):Play()
			end
		end
	end
end)

print("[HUD] COSOBOFFO HUD initialized")
