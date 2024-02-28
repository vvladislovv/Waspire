-- Very basic walking animation script by GnomeCode
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")

local RunAnim = script:WaitForChild("Run")
local RunAnimTrack = humanoid.Animator:LoadAnimation(RunAnim)

local StopAnim = script:WaitForChild("Stop")
local StopAnimTrack = humanoid.Animator:LoadAnimation(StopAnim)

local JumpAnim = script:WaitForChild("Jump")
local JumpAnimTrack = humanoid.Animator:LoadAnimation(JumpAnim)

local DiedAnim = script:WaitForChild("Died")
local DiedAnimTrack = humanoid.Animator:LoadAnimation(DiedAnim)

local SeatedAnim = script:WaitForChild("Seated")
local SeatedAnimTrack = humanoid.Animator:LoadAnimation(SeatedAnim)

local SwimmingAnim = script:WaitForChild("Swimming")
local SwimmingAnimTrack = humanoid.Animator:LoadAnimation(SwimmingAnim)

humanoid.Running:Connect(function(speed)
	if speed > 0.9 then
		if not RunAnimTrack.IsPlaying then
			RunAnimTrack:Play()
		end
	else
		if RunAnimTrack.IsPlaying then
			RunAnimTrack:Stop()
		end
	end
end)




humanoid.StateChanged:Connect(function()
	StopAnimTrack:Play()
	if humanoid:GetState() == Enum.HumanoidStateType.Jumping then
		JumpAnimTrack:Play()
	elseif humanoid:GetState() == Enum.HumanoidStateType.Landed then
		JumpAnimTrack:Stop()
	elseif humanoid:GetState() == Enum.HumanoidStateType.None then
		StopAnimTrack:Play()
		StopAnimTrack:AdjustSpeed(0.25)
	elseif humanoid:GetState() == Enum.HumanoidStateType.Dead then
		DiedAnimTrack:Play()
	elseif humanoid:GetState() == Enum.HumanoidStateType.Seated then
		SeatedAnimTrack:Play()
	elseif humanoid:GetState() == Enum.HumanoidStateType.Swimming then
		SwimmingAnimTrack:Play()
	end
	
end)