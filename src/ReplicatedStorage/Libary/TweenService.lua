local Tween = {}

local TweenService = game:GetService("TweenService")

function Tween:SizeBasicButtonOpen(Button)
    TweenService:Create(Button,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.new(10,0,5, 0)}):Play()
end

function Tween:SizeBasicButtonClose(Button)
    TweenService:Create(Button,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()
end


return Tween