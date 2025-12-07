local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local component = require(ReplicatedStorage.Packages.component)

local SIZE_TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local conveyorElement = component.new({Tag="ConveyorElement"})

function conveyorElement:Start()
    self.size = self.Instance.Size
    self:PlaySpawnEffect()
end

function conveyorElement:Stop()
    self:PlayDestroyEffect()
end

function conveyorElement:CreateClone()
    local clone = self.Instance:Clone()
    clone.Anchored = true
    clone.Position = self.Instance.Position
    clone:RemoveTag("ConveyorElement")
    clone.Parent = workspace

    return clone
end

function conveyorElement:PlaySpawnEffect()
    self.Instance.Size = Vector3.one / 10
    TweenService:Create(self.Instance, SIZE_TWEEN_INFO, { Size = self.size }):Play()
end

function conveyorElement:PlayDestroyEffect()
    local clone = self:CreateClone()
    local tween = TweenService:Create(clone, SIZE_TWEEN_INFO, { Size = Vector3.one / 10 })

    tween.Completed:Connect(function()
        Debris:AddItem(clone, 0)
    end)

    tween:Play()
end

return conveyorElement