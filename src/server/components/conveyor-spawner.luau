local ReplicatedStorage = game:GetService("ReplicatedStorage")
local component = require(ReplicatedStorage.Packages.component)
local timer = require(ReplicatedStorage.Packages.timer)

local conveyorSpawner = component.new({Tag="ConveyorSpawner"})

function conveyorSpawner:Start()
    self.timer = timer.new(1)
    
    self.timer.Tick:Connect(function()
       self:Spawn()
    end)

    self.timer:StartNow()
end

function conveyorSpawner:Spawn()
    local part = Instance.new("Part")
    part.Size = Vector3.one * 2.5
    part.CanCollide = true
    part.Anchored = false
    part.Position = self.Instance.Position
    part:AddTag("ConveyorElement")
    part.Parent = workspace
end

return conveyorSpawner