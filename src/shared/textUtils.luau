local textUtils = {}

function textUtils.getNumberRounded(num: number, places: number)
	local placeDivisor = math.pow(10, places)

	local numModified = num * placeDivisor
	numModified = numModified >= 0 and math.floor(numModified + 0.5) or math.ceil(numModified - 0.5)

	return tostring(numModified / placeDivisor)
end

return textUtils
