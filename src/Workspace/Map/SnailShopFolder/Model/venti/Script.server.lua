local RunService = game:GetService("RunService")

RunService.Stepped:Connect(function()
	script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(0,0,math.rad(1))
end)