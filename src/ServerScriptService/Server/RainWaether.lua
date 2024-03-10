local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remote")
local Data = require(script.Parent.Data)

local RainMain = {}

function Start(plr,NofficalBottle)

    local PData = Data:Get(plr)
    local SnowWeather = false
    local Part1 = Vector3.new(-530.48, 0.5, -474.904)
    local Part2 = Vector3.new(704.069, 0.5, 506.675)
    local random = Random.new(tick())
    PData.TimerTable["WatherEvent"].Time = os.time() + 15

    local function SnowPart(Min, max)
        return random:NextNumber(Min, max)
    end

    
local function CheckPartSnow()
    if SnowWeather then
        local SnowClone = ReplicatedStorage.Assert.Snow:Clone()
        SnowClone.Parent = workspace.WeatherFolder
        SnowClone.Anchored = false
        SnowClone.Position = Vector3.new(SnowPart(Part1.X,Part2.X), 1000, SnowPart(Part1.Z,Part2.Z)) 
    else
        for _, indexFolder in next, workspace.WeatherFolder:GetChildren() do
            indexFolder:Destroy()
            PData.TimerTable["WatherEvent"].Time = 0
            task.wait()
        end
    end 
end
       
    task.spawn(function()
        while true do
            task.wait()
            if NofficalBottle then
                SnowWeather = true
                CheckPartSnow(SnowWeather)
            else
                SnowWeather = false
                CheckPartSnow(SnowWeather)
            end
        end
    end)
end

Remote.RainServer.OnServerEvent:Connect(Start)

return RainMain