local JumpingEffect = {}
local plr = game.Players.LocalPlayer


local char = plr.Character or plr.CharacterAdded:Wait()

local humanoid = char:WaitForChild("Humanoid")


local hasJumped = false



humanoid.StateChanged:Connect(function(oldState, newState)


	if newState == Enum.HumanoidStateType.Jumping then


		if hasJumped then return end



		hasJumped = true



	elseif newState == Enum.HumanoidStateType.Landed then   

		game.ReplicatedStorage.Remote.JumpingEffect:FireServer()
		hasJumped = false
	end
end)

return JumpingEffect
