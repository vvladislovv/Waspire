
-- // Services
local contentProvider = game:GetService("ContentProvider")

-- // Variables
local assets = {}

-- // Loading the assets
for _, object in pairs(script:GetDescendants()) do
	if object:IsA("Folder") then continue end
	
	table.insert(assets, object)
end

-- // Content loading
contentProvider:PreloadAsync(assets)