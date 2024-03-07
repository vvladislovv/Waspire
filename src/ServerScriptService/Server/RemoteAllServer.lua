-- все ремуты которые нужны
local RemoteAllServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Data = require(script.Parent.Data)
local Remote = ReplicatedStorage:WaitForChild('Remote')

function BottalCoinData(Player, MathNumber)
    local PData = Data:Get(Player)
    PData.BaseSettings.Coin += MathNumber
end

Remote.BottalCoinEvent.OnServerEvent:Connect(BottalCoinData)

return RemoteAllServer