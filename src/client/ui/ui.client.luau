local Players = game:GetService("Players")

local layer = require("./components/composables/layer")
local test = require("./components/view/test")

local enterLayer = layer({IgnoreGuiInset = true, DisplayOrder = 0}, test)

enterLayer.Parent = Players.LocalPlayer.PlayerGui