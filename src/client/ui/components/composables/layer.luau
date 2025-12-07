local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Packages:FindFirstChild("vide"))
local create = vide.create

return function(props: {IgnoreGuiInset: boolean?, DisplayOrder: number?}, ...)
    return create "ScreenGui" {
        IgnoreGuiInset = props.IgnoreGuiInset or true,
        DisplayOrder = props.DisplayOrder or 1,
        ...
    }
end