local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Packages.vide)
local mount = vide.mount

local app = require("./components/view/app")

mount(app, Players.LocalPlayer.PlayerGui)
