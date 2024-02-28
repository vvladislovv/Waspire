local CameraType = {}
local runService = game:GetService("RunService")

local character = script.Parent.Parent
local humanoid = character:WaitForChild("Humanoid")

function updateBobbleEffect()
	local currentTime = tick()
	if humanoid.MoveDirection.Magnitude > 0 then -- we are walking
		local bobbleX = math.cos(currentTime * 10) * .15
		local bobbleY = math.abs(math.sin(currentTime * 10)) * .15

		local bobble = Vector3.new(bobbleX, bobbleY, 0)

		humanoid.CameraOffset = humanoid.CameraOffset:lerp(bobble, .15)
	else -- we are not walking
		humanoid.CameraOffset = humanoid.CameraOffset * 1
	end
end

runService.RenderStepped:Connect(updateBobbleEffect)

return CameraType
