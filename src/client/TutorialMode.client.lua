--!strict
-- TutorialMode.client.lua - COSOBOFFO
-- Onboarding diegetico per nuovi giocatori
-- Versione: 1.0 | Data: 2026-03-08

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function showTutorialMessage(text: string, duration: number)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TutorialGui"
    screenGui.Parent = PlayerGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.8, 0, 0.1, 0)
    label.Position = UDim2.new(0.1, 0, 0.2, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Text = text
    label.Font = Enum.Font.SpecialElite
    label.Parent = screenGui

    task.wait(duration)
    
    local tween = TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1, TextStrokeTransparency = 1})
    tween:Play()
    tween.Completed:Wait()
    screenGui:Destroy()
end

local function startTutorial()
    showTutorialMessage("Benvenuto nell'Archivio, Ricorrente.", 3)
    showTutorialMessage("Usa SHIFT per scattare, ma attento alla STAMINA.", 4)
    showTutorialMessage("Il SILENZIO è il tuo unico alleato.", 3)
    showTutorialMessage("Se vedi l'Osservatore, NON distogliere lo sguardo.", 5)
    showTutorialMessage("Recupera le Memorie e trova l'uscita.", 3)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    startTutorial()
end)

if LocalPlayer.Character then
    task.spawn(startTutorial)
end
