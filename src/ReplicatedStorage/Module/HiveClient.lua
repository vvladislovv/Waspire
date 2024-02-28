local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local Libary = ReplicatedStorage.Libary
local TweenModule = require(Libary.TweenService)
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character:WaitForChild('HumanoidRootPart')
local HiveFolder = workspace.Hive
_G.PData = Remote.GetDataSave:InvokeServer()

local HiveCleint = {}

function ButtonDistation(Distation, Button)

    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        NewHive()
    elseif Distation > 10 then
        TweenModule:SizeBasicButtonClose(Button)
    end
end


function NewHive() -- Взаимодействие с кнопкой
    
end

for _, IndexPlatform in next, HiveFolder:GetChildren() do

    task.spawn(function()
        while true do
            task.wait(0.1)
            local Distation = (IndexPlatform.Platform.Up.Indecator.Position - HumRootPart.Position).Magnitude
            ButtonDistation(Distation, IndexPlatform.Platform.Up.Indecator.Button)

        end
    end)

    Remote.HiveOwner:FireServer(IndexPlatform) -- для кнопки

    IndexPlatform.Platform.Down.Touched:Connect(function(hit)
        if Player.Character == hit.Parent then
            -- тут поменять на то чтобы человек нажимал на кнопку и если он нажал то вызывать и ставить улий иначе нихуя
            Remote.HiveSettings:FireServer(IndexPlatform)
            --IndexPlatform.Platform.Up.Indecator.Button
        end
    end)
end

return HiveCleint