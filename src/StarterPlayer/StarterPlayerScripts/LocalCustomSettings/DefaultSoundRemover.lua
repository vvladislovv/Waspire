local module = {}

-- // Services
local playersService = game:GetService("Players")

-- // Variables
local player = playersService.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- // Main loop
for _, object in pairs(rootPart:GetChildren()) do
	if object:IsA("Sound") then object:Destroy() end
end
return module
