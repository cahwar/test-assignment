local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local component = require(ReplicatedStorage.Packages.component)

local conveyorElement = component.new({Tag="ConveyorElement"})

function conveyorElement:Start()
    self.Instance:SetAttribute("Id", tostring(HttpService:GenerateGUID(false)))

    local clickDetector = Instance.new("ClickDetector", self.Instance)

    clickDetector.MouseClick:Connect(function()
        warn(`Server Id: {self.Instance:GetAttribute("Id")}`)
    end)
end

return conveyorElement