local Players = game:GetService("Players")

local layer = require("./components/composables/layer")

local enterLayer = layer({IgnoreGuiInset = true, DisplayOrder = 0})

enterLayer.Parent = Players.LocalPlayer.PlayerGui