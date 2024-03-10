local Bottal = {}
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local NofficalModule = require(game.ReplicatedStorage.Libary.Noffical)
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




function Bottal:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end



UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                if (Player:IsInGroup(GroupId)) and _G.PData.TimerTable["BottalCoin"].Time == 0 then
                    NofficalBottle = true
                    Remote.BottalCoinEvent:FireServer(NumbeMathRandomCoin, NofficalBottle) -- Написано на сервер на 10%
                    NofficalModule:NoficalClassicButtonRight("+"..NumbeMathRandomCoin.." Сoin (from Coin Dispenser)", NofficalBottle)
    
                    _G.PData.TimerTable["BottalCoin"].Time = os.time() + 14400
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = true
                    task.wait(3)
                    EffectFolder.EffectBottalCoin.ParticleEmitter.Enabled = false
                else
                    NofficalBottle = false
                    Remote.BottalCoinEvent:FireServer(NumbeMathRandomCoin, NofficalBottle)
                    NofficalModule:NoficalClassicButtonRight("Use the Bottle coin \n ("..utilsModule:FormatTime(_G.PData.TimerTable["BottalCoin"].Time - os.time()))
                end
            end
        end
    end
end)

return Bottal