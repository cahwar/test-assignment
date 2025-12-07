local Players = game:GetService("Players")
function onCharacterAdded(player: Player, character: Model)
    character:WaitForChild("HumanoidRootPart")
    character:AddTag("PlayerCharacter")
end

function onPlayerAdded(player: Player)
    local character = player.Character

    if character then
        onCharacterAdded(player, character)
    end

    player.CharacterAdded:Connect(function(character: Model)
        onCharacterAdded(player, character)
    end)
end

for _, player: Player in Players:GetPlayers() do
    task.spawn(onPlayerAdded, player)
end

Players.PlayerAdded:Connect(function(player: Player)
    onPlayerAdded(player)
end)