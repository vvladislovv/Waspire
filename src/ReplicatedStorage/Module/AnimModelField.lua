local AnimFlower = {}

local FieldModel = workspace.FieldModel
local Player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

function AnimFlower:AnimModel()
    for _, IndexFolder in next, FieldModel:GetChildren() do
        TweenService:Create(IndexFolder, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),{CFrame = IndexFolder.CFrame * CFrame.Angles(math.rad(math.random(-6,6)),math.rad(math.random(-6,6)),math.rad(math.random(-6,6)))}):Play()
    end
end

AnimFlower:AnimModel()

return AnimFlower