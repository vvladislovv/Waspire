local Collision = {}
local Player = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local GroupName = "Players"

PhysicsService:RegisterCollisionGroup(GroupName)
PhysicsService:CollisionGroupSetCollidable(GroupName, GroupName, false)

Player.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(Character)

		local function ChangeGroup(part)
			if part:IsA("BasePart") then
				PhysicsService:SetPartCollisionGroup(part, "Players")
			end
		end

		Character.ChildAdded:Connect(ChangeGroup)
		for _, object in pairs(Character:GetChildren()) do
			ChangeGroup(object)
		end
	end)
end)

return Collision