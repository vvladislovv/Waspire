local NofficalModule = {}
local Player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local PlayerGui = Player:WaitForChild("PlayerGui")
local UI = PlayerGui:WaitForChild('UI')
local TweenModule = require(game.ReplicatedStorage.Libary.TweenService)

local TableColorNofficalMSG = {
    Colors = {
        Variant1 = {[1] = Color3.fromRGB(74, 179, 172), [2] = Color3.fromRGB(71, 172, 165), [3] = Color3.fromRGB(82, 200, 190)}, -- Yes
        Variant2 = {[1] = Color3.fromRGB(179, 39, 111), [2] = Color3.fromRGB(154, 34, 96), [3] = Color3.fromRGB(182, 40, 113)}, -- No
    }
}

function NofficalModule:NoficalClassicButtonRight(Text, NofficalBottle)
    local Noffical = UI.Noffical
    if NofficalBottle then
        local Color = TableColorNofficalMSG.Colors.Variant1
        Noffical.BackgroundColor3 = Color[1]
        Noffical.NofficalColor2.BackgroundColor3 = Color[2]
        Noffical.NofficalColor2.NofficalColor3.BackgroundColor3 = Color[3]
        Noffical.NofficalColor2.NofficalColor3.TextLabel.Text = Text
        TweenModule:OpenNoffical(Noffical)
        task.wait(5)
        TweenModule:CloseNoffical(Noffical)
    else
        local Color = TableColorNofficalMSG.Colors.Variant2
        Noffical.BackgroundColor3 = Color[1]
        Noffical.NofficalColor2.BackgroundColor3 = Color[2]
        Noffical.NofficalColor2.NofficalColor3.BackgroundColor3 = Color[3]
        Noffical.NofficalColor2.NofficalColor3.TextLabel.Text = Text
        TweenModule:OpenNoffical(Noffical)
        task.wait(5)
        TweenModule:CloseNoffical(Noffical)
    end 
end


return NofficalModule