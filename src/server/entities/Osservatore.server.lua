--!strict
-- Osservatore.server.lua - COSOBOFFO
-- Entità: L'Osservatore, PATH B (Factory)
-- Versione: 1.1 | Data: 2026-03-09
-- Mechanic: "Don't Look" / "Look-Away". Se fissato troppo a lungo, attacca.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StateMachine = require(ReplicatedStorage.Modules.StateMachine)

local CONFIG = {
    name = "L'Osservatore",
    tier = "Correttore",
    lookThreshold = 2.0,
    detectionRange = 100,
    damage = 45,
    teleportChance = 0.3
}

local Osservatore = {}
Osservatore.__index = Osservatore

function Osservatore.new(instance: Model)
    local self = setmetatable({}, Osservatore)
    self.instance = instance
    self.target = nil
    self.lookTimer = 0
    
    self.fsm = StateMachine.new("Idle")
    self:SetupStates()
    
    return self
end

function Osservatore:SetupStates()
    self.fsm:AddState("Idle", {
        onEnter = function()
            self.instance:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
        end,
        onUpdate = function(dt)
            for _, p in ipairs(Players:GetPlayers()) do
                local char = p.Character
                if char and char.PrimaryPart then
                    self.target = char
                    self.fsm:ChangeState("Observing")
                    break
                end
            end
        end
    })
    
    self.fsm:AddState("Observing", {
        onUpdate = function(dt)
            if not self.target or not self.target.PrimaryPart then
                self.fsm:ChangeState("Idle")
                return
            end
            
            local head = self.target:FindFirstChild("Head")
            if head then
                local toEntity = (self.instance.PrimaryPart.Position - head.Position).Unit
                local lookDir = head.CFrame.LookVector
                local dot = lookDir:Dot(toEntity)
                
                if dot > 0.8 then
                    self.lookTimer += dt
                    if self.lookTimer > CONFIG.lookThreshold then
                        self.fsm:ChangeState("Aggressive")
                    end
                else
                    self.lookTimer = math.max(0, self.lookTimer - dt * 2)
                end
            end
        end
    })
    
    self.fsm:AddState("Aggressive", {
        onEnter = function()
            if self.target then
                local hum = self.target:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:TakeDamage(CONFIG.damage)
                end
            end
            self.fsm:ChangeState("Idle")
        end
    })
end

return Osservatore
