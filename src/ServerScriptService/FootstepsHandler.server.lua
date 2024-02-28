
-- // Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

-- // Variables
local footstepsModule = require(replicatedStorage:WaitForChild("FootstepsModule"))

-- // Functions
local function checkSpeed(humanoid)
	
	local walkSpeed = humanoid.WalkSpeed
	local moveDirection = humanoid.MoveDirection.Magnitude
	local floorMaterial = humanoid.FloorMaterial
	
	if walkSpeed > 0 and moveDirection > 0 and floorMaterial ~= Enum.Material.Air then
		return true
	end
	
	return false
end

local function getMaterial(material)
	local soundTable = footstepsModule:GetTableFromMaterial(material)
	
	if soundTable then
		local randomSound = footstepsModule:GetRandomSound(soundTable)
		
		if randomSound then
			return randomSound
		end
	end
	
	return nil
end

local function shootRay(rayOrigin, rayDirection, raycastParams)
	
	local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	
	if raycastResult then
		return raycastResult.Material
	end
	
	return nil
end

local function createFootstep(sound, character, rootPart)
	
	local rayOrigin = rootPart.Position
	local rayDirection = Vector3.new(0, -5, 0)
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.IgnoreWater = false
	raycastParams.FilterDescendantsInstances = {character}
	
	local raycastResult = shootRay(rayOrigin, rayDirection, raycastParams)
	
	if raycastResult ~= nil then
		local newSound = getMaterial(raycastResult)
		sound.SoundId = newSound
		
		local newFootstep = sound:Clone()
		newFootstep.Name = "Footstep"
		newFootstep.PlaybackSpeed = math.random(9, 11) / 10
		
		newFootstep.Parent = rootPart
		
		newFootstep:Play()
		newFootstep.Ended:Connect(function()
			newFootstep:Destroy()
		end)
	end
	
end

-- // Events
playersService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		
		local humanoid = character:WaitForChild("Humanoid")
		local rootPart = character:WaitForChild("HumanoidRootPart")
		
		-- Sound creation
		local footstepsSound = Instance.new("Sound")
		footstepsSound.Name = "FootstepTemplate"
		footstepsSound.Volume = 0.5
		
		footstepsSound.RollOffMode = Enum.RollOffMode.InverseTapered
		footstepsSound.RollOffMaxDistance = 35
		footstepsSound.RollOffMinDistance = 15
		
		footstepsSound.Parent = rootPart
		
		local cooldown = 0.4
		
		-- Main loop
		while humanoid.Health > 0 do
			task.wait(cooldown)
			
			if checkSpeed(humanoid) then
				createFootstep(footstepsSound, character, rootPart)
			end
		end
		
	end)
end)