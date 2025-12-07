local ReplicatedStorage = game:GetService("ReplicatedStorage")
local conveyorSpawner = require("./components/conveyor-spawner")

function setInterval(interval: number)
	for _, component in conveyorSpawner:GetAll() do
		component:SetSpawnInterval(interval)
	end
end

ReplicatedStorage.Remotes.SetInterval.OnServerEvent:Connect(function(player: Player, interval: number)
	setInterval(interval)
end)
