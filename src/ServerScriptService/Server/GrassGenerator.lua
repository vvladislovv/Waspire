local GrassGenerator = {}
-- Систему нужно дописать
--[[
local Min = 1
local Max = 10

local TableDestroyGrass = {
	[1] = "Tracks",
	[2] = "Hive1",
	[3] = "Hive2",
	[4] = "Hive3",
	[5] = "Hive4",
	[6] = "Hive5",
	[7] = "Hive6",
	[8] = "Hive7",
	[9] = "Hive8",
	[10] = "UnionStartSPW",
	[11] = "PlatformEvent",
	[12] = "WeatherEvent",
	[14] = "ShopCocun",
	[15] = "NPCMusquitp",
	[16] = "CaveGO",
	[17] = "CoinPLat",
	[18] = "NPCGarder",
	[19] = "ShopSnailModel",
	[20] = "ShopNubb",
	[21] = "FieldFolder",

}

function Destroy(GrassPart)
	task.spawn(function()
		task.wait()
		GrassPart.Touched:Connect(function(hit)
			local Player = game:GetService('Players'):GetPlayerFromCharacter(hit.Parent)
			if Player then
				return
			end
			for _, indexGrass in next, GrassPart:GetTouchingParts() do
				for _, TableGetItems in pairs(TableDestroyGrass) do
					if indexGrass == TableGetItems then
						GrassPart:Destroy()
					end
				end
			end
		end)
	end)
end

for _, SpawnPart in next, workspace.GrassMap:GetChildren() do
	local MaxGrass = SpawnPart.GrassMax.Value


	for i = 1,MaxGrass do
	
		local GrassPart = game.ServerStorage.Assets.GrassPoint1:Clone()
		local GrassPart1 = game.ServerStorage.Assets.GrassPoint2:Clone()


		if GrassPart ~= nil then
			local GrassParts = SpawnPart
			local GrassPartSize = GrassParts.Size

			local randomX = math.random(-GrassPartSize.X/2, GrassPartSize.X/2)
			-- local randomY = math.random(-GrassPartSize.Y/2, GrassPartSize.Y/2)
			local randomZ = math.random(-GrassPartSize.Z/2, GrassPartSize.Z/2)
			
			Destroy(GrassPart)
			GrassPart.Position = GrassParts.Position + Vector3.new(randomX, (GrassPartSize.Y/2) + (GrassPart.Size.Y/2.5), randomZ)
			GrassPart.Parent = workspace.GrassFolderAll

		elseif GrassPart1 ~= nil then
			local GrassParts = SpawnPart
			local GrassPartSize = GrassParts.Size

			local randomX = math.random(-GrassPartSize.X/2, GrassPartSize.X/2)
			--local randomY = math.random(-GrassPartSize.Y/2, GrassPartSize.Y/2)
			local randomZ = math.random(-GrassPartSize.Z/2, GrassPartSize.Z/2)
			
			Destroy(GrassPart1)
			GrassPart1.Position = GrassParts.Position + Vector3.new(randomX, (GrassPartSize.Y/2) + (GrassPart1.Size.Y/2.5), randomZ)
			GrassPart1.Parent = workspace.GrassFolderAll
		end
	end
end
]]

return GrassGenerator