local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Packages:FindFirstChild("vide"))
local create = vide.create

return create "Frame" {
    Size = UDim2.fromScale(0.5, 0.5),
    Position=UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
}