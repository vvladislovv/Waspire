-- все ремуты которые нужны
local RemoteAllServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Data = require(script.Parent.Data)
local Remote = ReplicatedStorage:WaitForChild('Remote')

function BottalCoinData(Player, MathNumber, NofficalBottle)
    local PData = Data:Get(Player)
    if NofficalBottle then
        PData.BaseSettings.Coin += MathNumber
        PData.TimerTable["BottalCoin"] = {Time = 14400 + os.time()}
        PData:Update('TimerTable', PData.TimerTable)
    else
        print(PData)
    end
end

function TutorialCheck(Player, Perment)
    local PData = Data:Get(Player)
    if Perment then
        PData.GameSettings.SnailTutorial = true
        PData:Update('GameSettings', PData.GameSettings)
    end
end

Remote.BottalCoinEvent.OnServerEvent:Connect(BottalCoinData)
Remote.TutorialServer.OnServerEvent:Connect(TutorialCheck)
return RemoteAllServer