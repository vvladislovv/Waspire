local TW = game:GetService("TweenService")
local Cooldun = 5

local EyesNPC = false

while task.wait(Cooldun) do
	TW:Create(script.Parent.EyeLeft, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In),{Size = Vector3.new(0.438, 0.167, 0.238)}):Play()
	TW:Create(script.Parent.EyeRight, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In),{Size = Vector3.new(0.438, 0.167, 0.238)}):Play()
	task.wait(0.3)
	TW:Create(script.Parent.EyeLeft, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In),{Size = Vector3.new(0.438, 0.571, 0.238)}):Play()
	TW:Create(script.Parent.EyeRight, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In),{Size = Vector3.new(0.438, 0.571, 0.238)}):Play()
end

