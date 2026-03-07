--!strict
local CinematicController = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

function CinematicController.PlayIntro()
	-- 2026 Tech: Smooth POV transition
	camera.CameraType = Enum.CameraType.Scriptable
	
	-- Starting position (Aerial shot of the Archive Hub)
	camera.CFrame = CFrame.new(Vector3.new(0, 50, 0), Vector3.new(0, 0, 0))
	
	local targetCFrame = CFrame.new(Vector3.new(0, 5, 10), Vector3.new(0, 5, 0))
	
	local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tween = TweenService:Create(camera, tweenInfo, {CFrame = targetCFrame})
	
	tween:Play()
	tween.Completed:Connect(function()
		print("Risveglio completato. Benvenuto nell'Archivio.")
		camera.CameraType = Enum.CameraType.Custom
	end)
end

-- Listen for intro trigger
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("StartIntro")
remote.OnClientEvent:Connect(CinematicController.PlayIntro)

return CinematicController
