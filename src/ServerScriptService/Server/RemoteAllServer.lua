-- все ремуты которые нужны
local RemoteAllServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
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

Remote.BottalCoinEvent.OnServerEvent:Connect(BottalCoinData)

return RemoteAllServer