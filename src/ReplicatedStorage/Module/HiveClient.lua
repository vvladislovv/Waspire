local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local Libary = ReplicatedStorage.Libary
local TweenModule = require(Libary.TweenService)
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character:WaitForChild('HumanoidRootPart')
local HiveFolder = workspace.Hive
local HiveStart = 0 -- проверка первый раз или нет
_G.PData = Remote.GetDataSave:InvokeServer()

local HiveCleint = {}

function ButtonDistation(Distation, Button, IndexPlatform)

    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        NewHive(IndexPlatform)
    elseif Distation > 10 then

        TweenModule:SizeBasicButtonClose(Button)
    end
end


function NewSlotsHiver(IndexHive)
    local AllSlot = IndexHive[_G.PData.Fake]
end

function HiveAndSlot(IndexHive)
    local NumerSlot = 0
    local SlotNumber = 0
    SlotNumber = _G.PData.Hive.Slot
    IndexHive.Material = Enum.Material.Neon
    --print(IndexHive.Material)
    TweenService:Create(IndexHive, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    IndexHive.Material = Enum.Material.SmoothPlastic
    local function SlotSpawnHive()

        local TweenInfoSlot = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
        
        if IndexHive.Name == "Hive1" then

            for _, i in next, IndexHive.SlotHive:GetChildren() do -- Check Slot AllHive
                NumerSlot += 1
            end

            local MaxSlot = math.max(NumerSlot) -- max slot

                if _G.PData.Hive.Slot then
                    print(_G.PData.Hive.Slot)
                    if SlotNumber == 35 then
                        TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    end
                    print(SlotNumber)
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                

        elseif IndexHive.Name == "Hive2" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        elseif IndexHive.Name == "Hive3" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        elseif IndexHive.Name == "Hive4" then --Orientation 0, 178.6, 90
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
           
        elseif IndexHive.Name == "Hive5" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        elseif IndexHive.Name == "Hive6" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        elseif IndexHive.Name == "Hive7" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        elseif IndexHive.Name == "Hive8" then
            local SlotHive = IndexHive.SlotHive
            --local SlotFolder = #SlotHive:GetChildren()
            
            --print(SlotFolder)
            for _, SlotFolder in next, IndexHive.SlotHive:GetChildren() do
                if _G.PData.Hive.Slot >= SlotNumber then
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                else -- дописать
                    TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                    SlotNumber += 1
                end
                task.wait(0.05)
                
                TweenService:Create(IndexHive.SlotHive["Slot"..SlotNumber], TweenInfoSlot, {Transparency = 0}):Play()
                SlotNumber += 1
            end
        end
    end
    SlotSpawnHive()
end

function NewHive(IndexHive) -- Взаимодействие с кнопкой
    IndexHive.Platform.Down.Touched:Connect(function(hit)
        if Player.Character == hit.Parent then
            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.E and HiveStart == 0 then
                    HiveStart = 1
                    Remote.HiveOwner:FireServer(IndexHive,HiveFolder)
                    Remote.HiveSettings:FireServer(IndexHive)
                    IndexHive.Platform.Up.Indecator.Button.Text.Image = "rbxassetid://16558543722"
                    HiveAndSlot(IndexHive)
                    --[[ -- Bag

                    -- {0.27, 0},{0.25, 0} для кнопки 
                elseif input.KeyCode == Enum.KeyCode.E and HiveStart == 1 then
                    IndexPlatform.Platform.Up.Indecator.Button.Text.Position = UDim2.new(0.27, 0,0.25, 0)
                    IndexPlatform.Platform.Up.Indecator.Button.Text.Image = "rbxassetid://16558543722"
                    HiveStart = 1

                elseif input.KeyCode == Enum.KeyCode.E and HiveStart == 2 then
                    IndexPlatform.Platform.Up.Indecator.Button.Text.Position = UDim2.new(0.27, 0,0.2, 0)
                    IndexPlatform.Platform.Up.Indecator.Button.Text.Image = "rbxassetid://16558543722"
                    HiveStart = 1]]
                end
            end)
            -- тут поменять на то чтобы человек нажимал на кнопку и если он нажал то вызывать и ставить улий иначе нихуя
            --IndexPlatform.Platform.Up.Indecator.Button
        end
    end)
end

for _, IndexHive in next, HiveFolder:GetChildren() do

    task.spawn(function()
        while true do
            task.wait(0.1)
            local Distation = (IndexHive.Platform.Up.Indecator.Position - HumRootPart.Position).Magnitude
            ButtonDistation(Distation, IndexHive.Platform.Up.Indecator.Button, IndexHive)

        end
    end)

    --Remote.HiveOwner:FireServer(IndexPlatform) -- для кнопки
end

return HiveCleint