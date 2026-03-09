--!strict
-- HUD.client.lua – COSOBOFFO (Enhanced v2.0 - 2026 Standards)
-- Immersione totale: No-HUD-numeric, camera shake, visual effects, stamina-feedback
-- Versione: 2.0 | Data: 2026-03-09

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local StaminaUpdate: RemoteEvent = Remotes:WaitForChild("StaminaUpdate")
local EntityChaseStart: RemoteEvent = Remotes:WaitForChild("EntityChaseStart")
local EntityChaseEnd: RemoteEvent = Remotes:WaitForChild("EntityChaseEnd")
local ObjectiveUpdate: RemoteEvent = Remotes:WaitForChild("ObjectiveUpdate")

-- ============================================================
-- UI & VISUAL EFFECTS SETUP
-- ============================================================
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "COSOBOFFO_IMMERSE_HUD"
screenGui.IgnoreGuiInset = true

-- Vignette (Immersive shadow)
local vignette = Instance.new("ImageLabel", screenGui)
vignette.Size = UDim2.new(1, 0, 1, 0)
vignette.BackgroundTransparency = 1
vignette.Image = "rbxassetid://1234567" -- Placeholder: vignette.png
vignette.ImageTransparency = 1
vignette.ImageColor3 = Color3.new(0,0,0)

-- Post-Processing
local colorCorrection = Lighting:FindFirstChild("StaminaCC") or Instance.new("ColorCorrectionEffect", Lighting)
colorCorrection.Name = "StaminaCC"
local blurEffect = Lighting:FindFirstChild("StaminaBlur") or Instance.new("BlurEffect", Lighting)
blurEffect.Name = "StaminaBlur"
blurEffect.Size = 0

-- Stamina bar (Minimalist line)
local bar = Instance.new("Frame", screenGui)
bar.Size = UDim2.new(0.3, 0, 0.005, 0)
bar.Position = UDim2.new(0.35, 0, 0.97, 0)
bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
bar.BackgroundTransparency = 0.8
local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(1, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- ============================================================
-- CORE LOGIC: CAMERA SHAKE & BOBBING
-- ============================================================
local shakeIntensity = 0
local function applyCameraShake(dt: number)
	if shakeIntensity > 0 then
		local offset = Vector3.new(
			(math.random() - 0.5) * shakeIntensity,
			(math.random() - 0.5) * shakeIntensity,
			0
		)
		camera.CFrame = camera.CFrame * CFrame.new(offset)
		shakeIntensity = math.max(0, shakeIntensity - dt * 2)
	end
end

RunService.RenderStepped:Connect(applyCameraShake)

-- ============================================================
-- EVENTS
-- ============================================================
StaminaUpdate.OnClientEvent:Connect(function(stamina: number, maxStam: number)
	local pct = stamina / maxStam
	fill:TweenSize(UDim2.new(pct, 0, 1, 0), "Out", "Quad", 0.1, true)
	
	-- Low Stamina Visuals (Desaturation + Blur)
	if pct < 0.25 then
		colorCorrection.Saturation = -1 + (pct * 4) -- Svanisce colore
		blurEffect.Size = (1 - (pct * 4)) * 10
		fill.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	else
		colorCorrection.Saturation = 0
		blurEffect.Size = 0
		fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end
end)

EntityChaseStart.OnClientEvent:Connect(function()
	shakeIntensity = 0.5
	TweenService:Create(vignette, TweenInfo.new(1), {ImageTransparency = 0.4}):Play()
	-- SoundManager.PlayHeartbeat(true) -- Inferred implementation
end)

EntityChaseEnd.OnClientEvent:Connect(function()
	TweenService:Create(vignette, TweenInfo.new(2), {ImageTransparency = 1}):Play()
end)

ObjectiveUpdate.OnClientEvent:Connect(function(msg)
	-- On-screen diegetic hint instead of persistent text
	local hint = Instance.new("TextLabel", screenGui)
	hint.Size = UDim2.new(1, 0, 0.1, 0)
	hint.Position = UDim2.new(0, 0, 0.2, 0)
	hint.Text = msg
	hint.BackgroundTransparency = 1
	hint.TextColor3 = Color3.new(1,1,1)
	hint.Font = Enum.Font.SpecialElite -- 2026 Retro-Analog vibe
	hint.TextSize = 24
	task.delay(3, function() hint:Destroy() end)
end)

print("[HUD] COSOBOFFO Enhanced HUD ready.")
