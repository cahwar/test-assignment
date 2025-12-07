local layer = require("../composables/layer")
local intervalSlider = require("./interval-slider")

return function()
	return layer({ IgnoreGuiInset = true, DisplayOrder = 0 }, intervalSlider())
end
