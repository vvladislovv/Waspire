local AnimFlower = {}

local FieldModel = workspace.FieldModel
local LeafFolder = workspace.AnimLeaftTree
local Player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

task.spawn(function()
    task.wait()
    for _, IndexFolder in next, FieldModel:GetChildren() do
		TweenService:Create(IndexFolder, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),{CFrame = IndexFolder.CFrame * CFrame.Angles(math.rad(math.random(-6,6)),math.rad(math.random(-6,6)),math.rad(math.random(-6,6)))}):Play()
	end
	for _, LeafIndex in next, LeafFolder:GetChildren() do
		TweenService:Create(LeafIndex, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),{CFrame = LeafIndex.CFrame * CFrame.Angles(math.rad(math.random(-3,3)),math.rad(math.random(-3,3)),math.rad(math.random(-3,3)))}):Play()
	end
end)


return AnimFlower