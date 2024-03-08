local Bottal = {}
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local Noffical = UI.Noffical
local ShopMiniClient = false
local NofficalBottle = false
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local EffectFolder = workspace.EffectFolder

local utilsModule = require(script.Parent.Parent.Parent.Libary.Utils)

_G.PData = Remote.GetDataSave:InvokeServer()
local NumbeMathRandomCoin = math.random(5000,25000)


local GroupId = 33683629

local TableColorNofficalMSG = {
    Colors = {
        Variant1 = {[1] = Color3.fromRGB(74, 179, 172), [2] = Color3.fromRGB(71, 172, 165), [3] = Color3.fromRGB(82, 200, 190)}, -- Yes
        Variant2 = {[1] = Color3.fromRGB(179, 39, 111), [2] = Color3.fromRGB(154, 34, 96), [3] = Color3.fromRGB(182, 40, 113)}, -- No
    }
}

function Bottal:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end


function NofficalGui(Color,Text, NofficalBottle) -- Дописать до конца(Написать Таймер)
    if NofficalBottle then
        Noffical.BackgroundColor3 = Color[1]
        Noffical.NofficalColor2.BackgroundColor3 = Color[2]
        Noffical.NofficalColor2.NofficalColor3.BackgroundColor3 = Color[3]
        Noffical.NofficalColor2.NofficalColor3.TextLabel.Text = Text
        TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,0.89, 0)}):Play()
        task.wait(5)
        TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,2, 0)}):Play()
    else
        Noffical.BackgroundColor3 = Color[1]
        Noffical.NofficalColor2.BackgroundColor3 = Color[2]
        Noffical.NofficalColor2.NofficalColor3.BackgroundColor3 = Color[3]
        Noffical.NofficalColor2.NofficalColor3.TextLabel.Text = Text
        TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,0.89, 0)}):Play()
        task.wait(5)
        TweenService:Create(Noffical, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 942,2, 0)}):Play()
    end 
    --TweenService:Create():Play()
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                if (Player:IsInGroup(GroupId)) and _G.PData.TimerTable["BottalCoin"].Time == 0 then
                    NofficalBottle = true
                    Remote.BottalCoinEvent:FireServer(NumbeMathRandomCoin, NofficalBottle) -- Написано на сервер на 10%
                    NofficalGui(TableColorNofficalMSG.Colors.Variant1,"+"..NumbeMathRandomCoin.." Сoin (from Coin Dispenser)", NofficalBottle)
                    _G.PData.TimerTable["BottalCoin"].Time = os.time() + 14400
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = true
                    task.wait(3)
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = false
                else
                    NofficalBottle = false
                    Remote.BottalCoinEvent:FireServer(NumbeMathRandomCoin, NofficalBottle)
                    NofficalGui(TableColorNofficalMSG.Colors.Variant2,"Use the Bottle coin \n ("..utilsModule:FormatTime(_G.PData.TimerTable["BottalCoin"].Time - os.time())..")", NofficalBottle)
                end
            end
        end
    end
end)

return Bottal