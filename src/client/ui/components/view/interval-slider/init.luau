local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local UserInputService = game:GetService("UserInputService")

local textUtils = require(ReplicatedStorage.Shared["textUtils"])
local useEvent = require(StarterPlayer.StarterPlayerScripts.Client.ui.hooks.useEvent)
local vide = require(ReplicatedStorage.Packages.vide)
local intervalConfig = require(ReplicatedStorage.Shared.intervalConfig)

local create = vide.create
local source = vide.source
local action = vide.action
local cleanup = vide.cleanup
local effect = vide.effect

local frameRef = source(nil :: Frame?)

local function captureRef()
	return action(function(instance: Instance)
		frameRef(instance :: Frame)

		cleanup(function()
			frameRef(nil)
		end)
	end)
end

local initialIsManager = ReplicatedStorage.Remotes.IsManager:InvokeServer()

return function()
	local isManager = source(initialIsManager)
	local isDragged = source(false)
	local dragAlpha = source(0.1)

	local intervalValue = function()
		return math.clamp(
			dragAlpha() * intervalConfig.MAX_INTERVAL,
			intervalConfig.MIN_INTERVAL,
			intervalConfig.MAX_INTERVAL
		)
	end

	local function onDrag()
		if not isDragged() then
			return
		end

		local mouseLocation = UserInputService:GetMouseLocation().X
		local framePosition = frameRef().AbsolutePosition.X
		local frameSize = frameRef().AbsoluteSize.X

		local pos = (mouseLocation - framePosition) / frameSize

		dragAlpha(math.clamp(pos, 0, 1))
	end

	useEvent(ReplicatedStorage.Remotes.AssignedManager.OnClientEvent, function()
		isManager(true)
	end)

	useEvent(UserInputService.TouchEnded, function()
		isDragged(false)
	end)

	useEvent(UserInputService.InputEnded, function(input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isDragged(false)
		end
	end)

	useEvent(UserInputService.TouchDrag, function() end)

	useEvent(UserInputService.InputChanged, function(input: InputObject, processedByUI: boolean)
		if processedByUI or not isDragged() then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			onDrag()
		end
	end)

	effect(function()
		if not isDragged() then
			local value = intervalValue()

			if value >= intervalConfig.MIN_INTERVAL and value <= intervalConfig.MAX_INTERVAL then
				ReplicatedStorage.Remotes.SetInterval:FireServer(intervalValue())
			end
		end
	end)

	return create("Frame")({
		captureRef(),

		BackgroundColor3 = Color3.fromRGB(113, 114, 242),
		Size = UDim2.fromScale(0.3, 0.1),
		Position = UDim2.fromScale(0.5, 0.9),
		AnchorPoint = Vector2.new(0.5, 1),

		Visible = function()
			return isManager()
		end,

		create("UICorner")({ CornerRadius = UDim.new(0.15, 0) }),

		create("UIStroke")({ Thickness = 5 }),

		create("ImageButton")({
			Image = "",
			BackgroundColor3 = Color3.fromRGB(166, 217, 255),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Size = UDim2.fromScale(0.8, 0.8),

			Position = function()
				return UDim2.fromScale(dragAlpha(), 0.5)
			end,

			AnchorPoint = function()
				return Vector2.new(dragAlpha(), 0.5)
			end,

			MouseButton1Down = function()
				isDragged(true)
			end,

			create("UICorner")({ CornerRadius = UDim.new(0.15, 0) }),
			create("UIStroke")({ Thickness = 5 }),

			create("TextLabel")({
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromScale(0.8, 0.8),
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Font = Enum.Font.FredokaOne,

				Text = function()
					return textUtils.getNumberRounded(intervalValue(), 2) .. "s"
				end,

				create("UIStroke")({ Thickness = 4 }),
			}),
		}),
	})
end
