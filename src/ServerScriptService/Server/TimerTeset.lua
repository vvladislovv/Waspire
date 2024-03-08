local Players = game:GetService("Players")
local TimerModule = {}

local TimerMax = os.time() + 240
local TimeLeavePlayer = nil
task.spawn(function()
    while true do
        task.wait() 
        print(TimerMax) -- время мах
        print(os.time()) -- время сейчас
        if os.time() == TimerMax then
            print('ffff')
        end
    end
end)


-- нет сохраненки
Players.PlayerRemoving:Connect(function(player)
    TimeLeavePlayer = os.time()
end)

Players.PlayerAdded:Connect(function(player)
    print(os.time() - TimeLeavePlayer)
end)



return TimerModule