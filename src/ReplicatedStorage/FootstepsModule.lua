-- Please confirm the author of this script was by "uglyburger0"
-- Any scripts under this module are viruses.
local main = {}

main.SoundIds = {
	["Bass"] = {
		"rbxassetid://9126748907",

	},
	
	["Carpet"] = {
		"rbxassetid://9126748130",

	},
	
	["Concrete"] = {
		"rbxassetid://9126746167",

	},
	
	["Dirt"] = {
		"rbxassetid://9126744390",
	},
	
	["Glass"] = {
		"rbxassetid://9126742971",

	},
	
	["Grass"] = {
		"rbxassetid://9126742396",

	},
	
	["Gravel"] = {
		"rbxassetid://9126741273",

	},
	
	["Ladder"] = {
		"rbxassetid://9126740217",

	},
	
	["Metal_Auto"] = {
		"rbxassetid://9126739090",

	},
	
	["Metal_Chainlink"] = {
		"rbxassetid://9126738423",

	},
	
	["Metal_Grate"] = {
		"rbxassetid://9126737728",

	},
	
	["Metal_Solid"] = {
		"rbxassetid://9126736470",

	},
	
	["Mud"] = {
		"rbxassetid://9126734842",

	},
	
	["Rubber"] = {
		"rbxassetid://9126734172",

	},
	
	["Sand"] = {
		"rbxassetid://9126733118",

	},
	
	["Snow"] = {
		"rbxassetid://9126732128",

	},
	
	["Tile"] = {
		"rbxassetid://9126730713",

	},
	
	["Wood"] = {
		"rbxassetid://9126931624",

	},
}

main.MaterialMap = {
	[Enum.Material.Slate] = 		main.SoundIds.Concrete,
	[Enum.Material.Concrete] = 		main.SoundIds.Concrete,
	[Enum.Material.Brick] = 		main.SoundIds.Concrete,
	[Enum.Material.Cobblestone] = 	main.SoundIds.Concrete,
	[Enum.Material.Sandstone] =		main.SoundIds.Concrete,
	[Enum.Material.Rock] = 			main.SoundIds.Concrete,
	[Enum.Material.Basalt] = 		main.SoundIds.Concrete,
	[Enum.Material.CrackedLava] = 	main.SoundIds.Concrete,
	[Enum.Material.Asphalt] = 		main.SoundIds.Concrete,
	[Enum.Material.Limestone] = 	main.SoundIds.Concrete,
	[Enum.Material.Pavement] = 		main.SoundIds.Concrete,

	[Enum.Material.Plastic] = 		main.SoundIds.Tile,
	[Enum.Material.Marble] = 		main.SoundIds.Tile,
	[Enum.Material.Neon] = 			main.SoundIds.Tile,
	[Enum.Material.Granite] = 		main.SoundIds.Tile,
	
	[Enum.Material.Wood] = 			main.SoundIds.Wood,
	[Enum.Material.WoodPlanks] = 	main.SoundIds.Wood,
	
	[Enum.Material.CorrodedMetal] = main.SoundIds.Metal_Auto,
	
	[Enum.Material.DiamondPlate] = 	main.SoundIds.Metal_Solid,
	[Enum.Material.Metal] = 		main.SoundIds.Metal_Solid,
	
	[Enum.Material.Ground] = 		main.SoundIds.Dirt,
	
	[Enum.Material.Grass] = 		main.SoundIds.Grass,
	[Enum.Material.LeafyGrass] = 	main.SoundIds.Grass,
	
	[Enum.Material.Fabric] = 		main.SoundIds.Carpet,
	
	[Enum.Material.Pebble] = 		main.SoundIds.Gravel,
	
	[Enum.Material.Snow] = 			main.SoundIds.Snow,
	[Enum.Material.Ice] = 			main.SoundIds.Snow,
	[Enum.Material.Glacier] = 		main.SoundIds.Snow,
	
	[Enum.Material.Sand] = 			main.SoundIds.Sand,
	[Enum.Material.Salt] = 			main.SoundIds.Sand,

	[Enum.Material.Glass] = 		main.SoundIds.Glass,
	
	[Enum.Material.SmoothPlastic] = main.SoundIds.Rubber,
	[Enum.Material.ForceField] = 	main.SoundIds.Rubber,
	[Enum.Material.Foil] = 			main.SoundIds.Rubber,
	
	[Enum.Material.Mud] = 			main.SoundIds.Mud,
}

-- This function produces a folder under a specified parent.
-- "soundProperties" is a table determining what the default properties of these audios will be.
function main:CreateSoundGroup(parent:Instance?, name:string?, soundProperties:{}?, isFolder:boolean?) : SoundGroup|Folder
	if not parent then warn("Parent not specified, Footstep folder parented to workspace") end
	isFolder = isFolder or false
	soundProperties = soundProperties or {}
	parent = parent or workspace
	-- Create folder
	local SoundGroup = nil
	if not isFolder then
		SoundGroup = Instance.new("SoundGroup"); SoundGroup.Volume = 1; SoundGroup.Name = name or "Footsteps"
	else
		SoundGroup = Instance.new("Folder"); SoundGroup.Name = name or "Footsteps"
	end
	local index = 0
	for soundMaterial,soundList in pairs(main.SoundIds) do
		index = 0
		local sectionGroup = nil
		if not isFolder then
			sectionGroup = Instance.new("SoundGroup"); sectionGroup.Volume = 1; sectionGroup.Name = soundMaterial
		else
			sectionGroup = Instance.new("Folder"); sectionGroup.Name = soundMaterial
		end
		for _,soundId in pairs(soundList) do
			index += 1 -- Increment index
			local soundEffect = Instance.new("Sound")
			soundEffect.Name = string.format("%s_%02i",soundMaterial:lower(),index)
			-- Set optional sound group
			if not isFolder then
				soundEffect.SoundGroup = sectionGroup
			end
			for property,value in pairs(soundProperties) do
				soundEffect[property] = value
			end
			soundEffect.SoundId = soundId
			soundEffect.Parent = sectionGroup
		end
		sectionGroup.Parent = SoundGroup
	end
	
	SoundGroup.Parent = parent
	return SoundGroup
end

-- This function returns a table from the MaterialMap given the material.
function main:GetTableFromMaterial(EnumItem : Enum.Material|string) : {}
	if typeof(EnumItem) == "string" then -- CONVERSION
		EnumItem = Enum.Material[EnumItem]
	end
	return main.MaterialMap[EnumItem]
end

-- This function is a primitive "pick randomly from table" function.
function main:GetRandomSound(SoundTable : {}) : string
	return SoundTable[math.random(#SoundTable)]
end

return main