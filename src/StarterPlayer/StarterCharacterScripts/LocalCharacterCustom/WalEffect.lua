local EffectWalk = {}

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
--parts needed for the effect
local lfoot = character:WaitForChild("HeelRight")
local rfoot = character:WaitForChild("HeelLeft")
--getting the particle effects
local ef1 = game.ReplicatedStorage:WaitForChild('walkk').ef:Clone()
ef1.Parent = rfoot
local ef3 = game.ReplicatedStorage:WaitForChild('walkk').ef:Clone()
ef3.Parent = lfoot
--checking if the humanoid is running 
humanoid.Running:Connect(function(speed)
	if speed > 2 then
		ef1.Enabled  = true
		ef3.Enabled  = true

	else
		ef1.Enabled  = false
		ef3.Enabled  = false

	end
end)
--we disable the effect if the user is jumping
humanoid.Jumping:Connect(function(isjumping)
	if isjumping then
		ef1.Enabled  = false
		ef3.Enabled  = false
	end
end)

return EffectWalk
