local Bottal = {}
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ShopMiniClient = false
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local EffectFolder = workspace.EffectFolder

local GroupId = 33683629

local TableColorNofficalMSG = {
    Colors = {
        Variant1 = {Color1 = Color3.new(74, 179, 172),Color2 = Color3.new(71, 172, 165), Color3 = Color3.new(82, 200, 190)}, -- Yes
        Variant2 = {Color1 = Color3.new(179, 39, 111),Color2 = Color3.new(154, 34, 96), Color3 = Color3.new(182, 40, 113)}, -- No
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

function NofficalGui(Color,Text) -- Дописать до конца
    TweenService:Create()
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                if (Player:IsInGroup(GroupId)) then
                    Remote.BottalCoinEvent:FireServer() -- Написано на сервер на 10%
                    NofficalGui(TableColorNofficalMSG.Colors.Variant1,"")
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = true
                    task.wait(3)
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = false
                else
                    NofficalGui(TableColorNofficalMSG.Colors.Variant2,"")
                end
            end
        end
    end
end)

return Bottal