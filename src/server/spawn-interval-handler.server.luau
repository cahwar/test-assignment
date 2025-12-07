local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local conveyorSpawner = require("./components/conveyor-spawner")

local MANAGERS_COUNT = 1

local managers = {} :: { Player }

function addManager(player: Player)
	if not table.find(managers, player) then
		table.insert(managers, player)
	end

	ReplicatedStorage.Remotes.AssignedManager:FireClient(player)
end

function onPlayerAdded(player: Player)
	if #managers < MANAGERS_COUNT then
		addManager(player)
	end
end

function setInterval(interval: number)
	for _, component in conveyorSpawner:GetAll() do
		component:SetSpawnInterval(interval)
	end
end

for _, player: Player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end

Players.PlayerAdded.Connect(function(player: Player)
	onPlayerAdded(player)
end)

ReplicatedStorage.Remotes.SetInterval.OnServerEvent:Connect(function(player: Player, interval: number)
	setInterval(interval)
end)

ReplicatedStorage.Remotes.IsManager.OnServerInvoke = function(player: Player)
	return table.find(managers, player) ~= nil
end
