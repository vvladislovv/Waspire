local HeadClientCamera = {}
local tweenService = game:GetService("TweenService")

local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer

local Character = Player.Character
local Root = Character:WaitForChild("HumanoidRootPart")
local Neck = Character:WaitForChild('Head'):FindFirstChild("Neck")
local YOffset = Neck.C0.Y

local CFNew, CFAng = CFrame.new, CFrame.Angles
local asin = math.asin

game:GetService("RunService").RenderStepped:Connect(function()
	local CameraDirection = Root.CFrame:toObjectSpace(Camera.CFrame).lookVector
	if Neck then
		if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			Neck.C0 = CFNew(0, YOffset, 0) * CFAng(0, -asin(CameraDirection.x), 0) * CFAng(asin(CameraDirection.y), 0, 0)
		elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
			Neck.C0 = CFNew(0, YOffset, 0) * CFAng(3 * math.pi/2, 0, math.pi) * CFAng(0, 0, -asin(CameraDirection.x)) * CFAng(-asin(CameraDirection.y), 0, 0)
		end
	end
end)

game.ReplicatedStorage.Remote.Look.OnClientEvent:Connect(function(otherPlayer, neckCFrame)
	local Neck = otherPlayer.Character:FindFirstChild("Neck", true)

	if Neck then
		tweenService:Create(Neck, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = neckCFrame}):Play()
	end
end)

while wait(1) do
	game.ReplicatedStorage.Remote.Look:FireServer(Neck.C0)
end
return HeadClientCamera
