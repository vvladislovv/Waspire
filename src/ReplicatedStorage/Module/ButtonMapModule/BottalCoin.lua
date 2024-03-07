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

local NumbeMathRandomCoin = math.random(4356,156535)
local GroupId = 33683629

local TableColorNofficalMSG = {
    Colors = {
        Variant1 = {[1] = Color3.fromRGB(74, 179, 172), [2] = Color3.fromRGB(71, 172, 165), [3] = Color3.fromRGB(82, 200, 190)}, -- Yes
        --Variant2 = {["Color1"] = Color3.fromRGB(179, 39, 111), ["Color2"] = Color3.fromRGB(154, 34, 96), ["Color3"] = Color3.fromRGB(182, 40, 113)}, -- No
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

function TimerBottal(Hour,Minute,Second) -- таймер должен быть в дате(Посмотреть os.time)
    task.spawn(function()
        task.wait()
        repeat
            if Hour <= 0 then
                Hour = Hour - 1
                Minute = 59
                Second = 59
            end

            if Second <= 0 then
                Minute = Minute - 1
                Second = 59
            else
                Second = Second - 1
            end
            print(tostring(Hour)..":"..tostring(Minute)..":"..tostring(Second))
            task.wait(1)
    
        until Hour <= 0 and Minute <= 0 and Second <= 0
    end)
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
        TimerBottal(1,59,59)
    else

    end 
    --TweenService:Create():Play()
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                if (Player:IsInGroup(GroupId)) then
                    NofficalBottle = true
                    Remote.BottalCoinEvent:FireServer(NumbeMathRandomCoin) -- Написано на сервер на 10%
                    NofficalGui(TableColorNofficalMSG.Colors.Variant1,"+"..NumbeMathRandomCoin.." Сoin (from Coin Dispenser)", NofficalBottle)
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = true
                    task.wait(3)
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = false
                else
                    NofficalBottle = false
                    NofficalGui(TableColorNofficalMSG.Colors.Variant2,"", NofficalBottle)
                end
            end
        end
    end
end)

return Bottal