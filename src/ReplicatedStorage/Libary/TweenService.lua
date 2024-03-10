local Tween = {}

local TweenService = game:GetService("TweenService")

function Tween:SizeBasicButtonOpen(Button)
    TweenService:Create(Button,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.new(10,0,5, 0)}):Play()
end

function Tween:SizeBasicButtonClose(Button)
    TweenService:Create(Button,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()
end

function Tween:OpenNoffical(Noffical)
    TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,0.89, 0)}):Play()
end


function Tween:CloseNoffical(Noffical)
    TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,2, 0)}):Play()
end

function Tween:TransparencyBlack(FrameBlackTeleport)
    TweenService:Create(FrameBlackTeleport, TweenInfo.new(0.8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {Transparency = 0}):Play()
end

return Tween