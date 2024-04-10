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

function ButtonDistation(Distation, Button, IndexHive)

    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        NewHive(IndexHive)
        --print('aa')
    elseif Distation > 10 then
        TweenModule:SizeBasicButtonClose(Button)
    end

    if IndexHive.Owner.Value ~= "" then
        if IndexHive.Owner.Value == Player.Name then
            if Distation < 10 then
                TweenModule:SizeBasicButtonOpen(Button)
            elseif Distation > 10 then
                TweenModule:SizeBasicButtonClose(Button)
            end
        else
            IndexHive.Highlight.Enabled = false
            IndexHive.Platform.Highlight.Enabled = false
            IndexHive.Platform.Up.Indecator.Button.Enabled = false
            TweenModule:SizeBasicButtonClose(Button)
        end
    end
end



function ButtonCheckClient(IndexHive)

    print(_G.PData.BaseFakeSettings.HiveNumberOwner)
    if _G.PData.BaseFakeSettings.HiveNumberOwner == IndexHive then -- тут проблема пустая строка 
        IndexHive.Highlight.Enabled = true
        IndexHive.Platform.Highlight.Enabled = true
        IndexHive.Platform.Up.Indecator.Button.Enabled = true
    else
        for _, AllHive in next, HiveFolder:GetChildren() do
            if _G.PData.BaseFakeSettings.HiveNumberOwner ~= AllHive.Name then
                --print(AllHive)
                --print(AllHive:FindFirstChild("Button"))
                Player.Character.UpperTorso.BeamHive:Destroy()
                AllHive.Platform.Up.Indecator.Button.Enabled = false
                AllHive.Platform.Highlight.Enabled = false
                AllHive.Highlight.Enabled = false
            else
                Player.Character.UpperTorso.BeamHive:Destroy()
            end
        end
        Remote.HiveButtonCheck:FireServer(IndexHive)
    end
end

function BeanCheckGame(Character, HiveFolder)
    task.spawn(function()
        task.wait()
        local BeamHive = game:GetService("ReplicatedStorage").Assert.BeamHive
        local UpperTorso = Character.UpperTorso
        local AttachmentPlayer = Character.UpperTorso.AttachmentPlayer
        local Count = 0
        local CountStart = 0

        for _, IndexHive in next, HiveFolder:GetChildren() do
            if IndexHive.Owner.Value == "" then
                Count += 1
            end
        end
        repeat
            task.wait()
            for _, IndexHive in next, HiveFolder:GetChildren() do
                if IndexHive.Owner.Value == "" then
                    local BeamHiveClone = BeamHive:Clone()
                    BeamHiveClone.Parent = UpperTorso
                    BeamHiveClone.Attachment0 = AttachmentPlayer
                    BeamHiveClone.Attachment1 = IndexHive.Platform.Up.Indecator.AttachmentHive
                    CountStart += 1
                end
            end
            
        until CountStart == Count
    end)
end

function NewHive(IndexHive) -- Взаимодействие с кнопкой
    IndexHive.Platform.Down.Touched:Connect(function(hit)
        if Player.Character == hit.Parent then
            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.E and HiveStart == 0 then
                    HiveStart = 1
                    _G.PData.BaseFakeSettings.HiveNumberOwner = IndexHive.Name
                   -- TweenService:Create(IndexHive.Platform.Up.Indecator.Button.ButtonE, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.In),{ImageColor3 =Color3.fromRGB(170, 170, 170)}):Play()
                   -- task.wait(0.3)
                    --TweenService:Create(IndexHive.Platform.Up.Indecator.Button.ButtonE, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.In),{ImageColor3 =Color3.fromRGB(255, 255, 255)}):Play()
                    Remote.HiveOwner:FireServer(IndexHive,HiveFolder)
                    Remote.HiveSettings:FireServer(IndexHive)
                    Remote.HiveSpawnSlot:FireServer(IndexHive)
                    IndexHive.Platform.Up.Indecator.Button.Text.Image = "rbxassetid://16558543722"
                    ButtonCheckClient(IndexHive)

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
BeanCheckGame(Player.Character, HiveFolder)
for _, IndexHive in next, HiveFolder:GetChildren() do

    task.spawn(function()
        while true do
            task.wait(0.1)
            local Distation = (IndexHive.Platform.Up.Indecator.Position - HumRootPart.Position).Magnitude
            ButtonDistation(Distation, IndexHive.Platform.Up.Indecator.Button, IndexHive)
        end
    end)
end

return HiveCleint