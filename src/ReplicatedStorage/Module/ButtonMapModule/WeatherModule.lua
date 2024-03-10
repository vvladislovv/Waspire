local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local NofficalModule = require(game.ReplicatedStorage.Libary.Noffical)
local NofficalBottle = false
local player = game.Players.LocalPlayer
local ShopMiniClient = false
local Remote = ReplicatedStorage:WaitForChild('Remote')
local UserInputService = game:GetService("UserInputService")
_G.PData = Remote.GetDataSave:InvokeServer()

local GroupId = 33683629
local WeatherModule = {}

function WeatherModule:OpenShop(ShopMini)
    task.wait()

    if _G.PData.TimerTable["WatherEvent"].Time == os.time() then
        NofficalBottle = false
        Remote.RainServer:FireServer(NofficalBottle)
        _G.PData.TimerTable["WatherEvent"].Time = 0
    end

    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E and  _G.PData.TimerTable["WatherEvent"].Time == 0 then
                if (player:IsInGroup(GroupId)) then
                    _G.PData.TimerTable["WatherEvent"].Time = os.time() + 15
                    NofficalBottle = true
                    NofficalModule:NoficalClassicButtonRight("You use Snow...", NofficalBottle)
                    Remote.RainServer:FireServer(NofficalBottle)
                else
                    NofficalBottle = false
                    NofficalModule:NoficalClassicButtonRight("You not is use Snow...", NofficalBottle)
                end
            end
        end
    end
end)



return WeatherModule