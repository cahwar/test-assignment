local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local component = require(ReplicatedStorage.Packages.component)

local directionTexture = component.new({Tag="DirectionTexture"})

function directionTexture:Start()
    self.connection = RunService.Heartbeat:Connect(function()
        self.Instance.OffsetStudsU += 0.05
    end)
end

return directionTexture