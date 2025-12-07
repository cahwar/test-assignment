local ReplicatedStorage = game:GetService("ReplicatedStorage")
local component = require(ReplicatedStorage.Packages.component)
local zoneplus = require(ReplicatedStorage.Packages.zoneplus)

local conveyorRemover = component.new({Tag="ConveyorRemover"})

function conveyorRemover:Start()
    self.zone = zoneplus.new(self.Instance)

    warn(self.zone)
    
    self.zone.partEntered:Connect(function(item : BasePart | Model)
        if (item:HasTag("ConveyorElement")) then
            item:Destroy()
        end
    end)
end
return conveyorRemover