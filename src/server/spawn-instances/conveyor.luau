local Workspace = game:GetService("Workspace")
local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "Model";
	Properties = {
		Name = "Conveyor";
	};
	Children = {
		{
			ID = 1;
			Type = "Model";
			Properties = {};
			Children = {
				{
					ID = 2;
					Type = "Part";
					Properties = {
						BrickColor = BrickColor.new(10/17,103/255,2/5);
						Size = Vector3.new(0.20000000298023224,1.399999976158142,7.749976634979248);
						brickColor = BrickColor.new(10/17,103/255,2/5);
						Position = Vector3.new(16.60000991821289,0.7000030875205994,20.22498321533203);
						Color = Color3.new(10/17,103/255,2/5);
						CFrame = CFrame.new(16.60000991821289,0.7000030875205994,20.22498321533203,1,0,0,0,1,0,0,0,1);
						BottomSurface = Enum.SurfaceType.Smooth;
						TopSurface = Enum.SurfaceType.Smooth;
					};
					Children = {};
				};
				{
					ID = 3;
					Type = "Part";
					Properties = {
						BrickColor = BrickColor.new(10/17,103/255,2/5);
						Size = Vector3.new(0.20000000298023224,1.399999976158142,7.749976634979248);
						brickColor = BrickColor.new(10/17,103/255,2/5);
						Position = Vector3.new(-33.599979400634766,0.7000030875205994,20.22498321533203);
						Color = Color3.new(10/17,103/255,2/5);
						CFrame = CFrame.new(-33.599979400634766,0.7000030875205994,20.22498321533203,1,0,0,0,1,0,0,0,1);
						BottomSurface = Enum.SurfaceType.Smooth;
						TopSurface = Enum.SurfaceType.Smooth;
					};
					Children = {};
				};
				{
					ID = 4;
					Type = "Part";
					Properties = {
						BrickColor = BrickColor.new(10/17,103/255,2/5);
						Size = Vector3.new(50.39997863769531,1.399999976158142,0.5);
						brickColor = BrickColor.new(10/17,103/255,2/5);
						Position = Vector3.new(-8.499959945678711,0.699999988079071,16.09999656677246);
						Color = Color3.new(10/17,103/255,2/5);
						CFrame = CFrame.new(-8.499959945678711,0.699999988079071,16.09999656677246,1,0,0,0,1,0,0,0,1);
						BottomSurface = Enum.SurfaceType.Smooth;
						TopSurface = Enum.SurfaceType.Smooth;
					};
					Children = {};
				};
				{
					ID = 5;
					Type = "Part";
					Properties = {
						BrickColor = BrickColor.new(10/17,103/255,2/5);
						Size = Vector3.new(50.39997863769531,1.399999976158142,0.5);
						brickColor = BrickColor.new(10/17,103/255,2/5);
						Position = Vector3.new(-8.499959945678711,0.699999988079071,24.349973678588867);
						Color = Color3.new(10/17,103/255,2/5);
						CFrame = CFrame.new(-8.499959945678711,0.699999988079071,24.349973678588867,1,0,0,0,1,0,0,0,1);
						BottomSurface = Enum.SurfaceType.Smooth;
						TopSurface = Enum.SurfaceType.Smooth;
					};
					Children = {};
				};
			};
		};
		{
			ID = 6;
			Type = "Part";
			Properties = {
				BottomSurface = Enum.SurfaceType.Smooth;
				Color = Color3.new(86/255,22/85,18/85);
				CFrame = CFrame.new(-8.499996185302734,0.30000007152557373,20.09999656677246,1,0,0,0,1,0,0,0,1);
				Name = "Primary";
				Position = Vector3.new(-8.499996185302734,0.30000007152557373,20.09999656677246);
				BrickColor = BrickColor.new(86/255,22/85,18/85);
				Size = Vector3.new(50,0.6000000238418579,8);
				brickColor = BrickColor.new(86/255,22/85,18/85);
				TopSurface = Enum.SurfaceType.Smooth;
			};
			Children = {
				{
					ID = 7;
					Type = "Texture";
					Properties = {
						Transparency = 0.800000011920929;
						StudsPerTileV = 8;
						Face = Enum.NormalId.Top;
						Texture = "rbxassetid://17368179471";
						StudsPerTileU = 8;
					};
					Tags = {"DirectionTexture"},
					Children = {};
				};
			};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	
	if(item.Tags) then
		for _, tag in pairs(item.Tags) do
			obj:AddTag(tag)
		end
	end

	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

return function() return Scan(root, Workspace) end