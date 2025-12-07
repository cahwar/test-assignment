local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)

local effect = vide.effect
local cleanup = vide.cleanup

return function(event: RBXScriptSignal, callback)
	effect(function()
		local connection = event:Connect(callback)

		cleanup(function()
			connection:Disconnect()
		end)
	end)
end
