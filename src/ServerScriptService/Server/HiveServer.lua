local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local Data = require(script.Parent.Data)
local TweenService = game:GetService('TweenService')
local HiveFolder = workspace.Hive

local HiveServer = {}


function HiveSettingsBasic(Player, IndexHive) -- Косание локал(Изменения на севере)
    local PData = Data:Get(Player)
    if PData.BaseFakeSettings.HiveOwner == "" then
        IndexHive.Platform.Up.Indecator.AttachmentHive:Destroy()
        IndexHive.Owner.Value = Player.Name
        IndexHive.NamePlayerHive.BillboardGui.TextLabel.Text = Player.Name
        PData.BaseFakeSettings.HiveNumberOwner = IndexHive.Name

        PData.BaseFakeSettings.HiveOwner = Player.Name
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end

end

function HiveAndSlot(Plr, IndexHive)
    local PData = Data:Get(Plr)

    local function SpawnHiveEffect()
        IndexHive.Material = Enum.Material.Neon
        TweenService:Create(IndexHive, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {Color = Color3.fromRGB(255, 255, 255)}):Play()
        IndexHive.Material = Enum.Material.SmoothPlastic
    end

    local function SlotSpawnHive()

        local TweenInfoSlot = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
        
        if IndexHive.Name == "Hive1" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive2" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive3" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive4" then --Orientation 0, 178.6, 90
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive5" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive6" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive7" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        elseif IndexHive.Name == "Hive8" then
            if PData.Hive.Slot then
                local CheckSlotPlayer = PData.Hive.Slot
                local CheckSlot = 0
                if CheckSlotPlayer ~= CheckSlot then
                    repeat
                        CheckSlot += 1
                        TweenService:Create(IndexHive.SlotHive["Slot"..CheckSlot], TweenInfoSlot, {Transparency = 0}):Play()
                    until CheckSlotPlayer == CheckSlot
                end
            end
        end
    end

    SpawnHiveEffect()
    SlotSpawnHive()

end



function ButtonServerCheckPlayer(Plr, IndexHive)
    task.spawn(function()
        for _, Index in next, HiveFolder:GetChildren() do
            while true do
                task.wait()
                if IndexHive.Owner.Value ~= "" and Plr then
                    if Index.Name ~= IndexHive.Name then
                        Index.Platform.Highlight.Enabled = true
                        Index.Platform.Highlight.Enabled = true
                        Index.Platform.Up.Indecator.Button.Enabled = true
                    end
                end
            end 
        end
    end)
end


function CheckButton(Player, AllHive) -- переписать на склиент
    task.spawn(function()
        while true do
            task.wait()
            --print(Player)
            --print(Player.Character.UpperTorso)
            --print(IndexPlatform.Owner.Value)
            
            if AllHive.Hive1.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam1.Enabled = false
                AllHive.Hive1.Highlight.Enabled = true
                AllHive.Hive1.Platform.Highlight.Enabled = true
                AllHive.Hive1.Platform.Up.Indecator.Button.Enabled = true
            else
                --print('fff')
                Player.Character.UpperTorso.Beam1.Enabled = false
                AllHive.Hive1.Highlight.Enabled = false
                AllHive.Hive1.Platform.Highlight.Enabled = false
                AllHive.Hive1.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive2.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam2.Enabled = false
                AllHive.Hive2.Highlight.Enabled = true
                AllHive.Hive2.Platform.Highlight.Enabled = true
                AllHive.Hive2.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam2.Enabled = false
                AllHive.Hive2.Highlight.Enabled = false
                AllHive.Hive2.Platform.Highlight.Enabled = false
                AllHive.Hive2.Platform.Up.Indecator.Button.Enabled = false
            end
            
            if AllHive.Hive3.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam3.Enabled = false
                AllHive.Hive3.Highlight.Enabled = true
                AllHive.Hive3.Platform.Highlight.Enabled = true
                AllHive.Hive3.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam3.Enabled = false
                AllHive.Hive3.Highlight.Enabled = false
                AllHive.Hive3.Platform.Highlight.Enabled = false
                AllHive.Hive3.Platform.Up.Indecator.Button.Enabled= false
            end

            if AllHive.Hive4.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam4.Enabled = false
                AllHive.Hive4.Highlight.Enabled = true
                AllHive.Hive4.Platform.Highlight.Enabled = true
                AllHive.Hive4.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam4.Enabled = false
                AllHive.Hive4.Highlight.Enabled = false
                AllHive.Hive4.Platform.Highlight.Enabled = false
                AllHive.Hive4.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive5.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam5.Enabled = false
                AllHive.Hive5.Highlight.Enabled = true
                AllHive.Hive5.Platform.Highlight.Enabled = true
                AllHive.Hive5.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam5.Enabled = false
                AllHive.Hive5.Highlight.Enabled = false
                AllHive.Hive5.Platform.Highlight.Enabled = false
                AllHive.Hive5.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive6.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam6.Enabled = false
                AllHive.Hive6.Highlight.Enabled = true
                AllHive.Hive6.Platform.Highlight.Enabled = true
                AllHive.Hive6.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam6.Enabled = false
                AllHive.Hive6.Highlight.Enabled = false
                AllHive.Hive6.Platform.Highlight.Enabled = false
                AllHive.Hive6.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive7.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam7.Enabled = false
                AllHive.Hive7.Highlight.Enabled = true
                AllHive.Hive7.Platform.Highlight.Enabled = true
                AllHive.Hive7.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam7.Enabled = false
                AllHive.Hive7.Highlight.Enabled = false
                AllHive.Hive7.Platform.Highlight.Enabled = false
                AllHive.Hive7.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive8.Owner.Value ~= "" then
                Player.Character.UpperTorso.Beam8.Enabled = false
                AllHive.Hive8.Highlight.Enabled = true
                AllHive.Hive8.Platform.Highlight.Enabled = true
                AllHive.Hive8.Platform.Up.Indecator.Button.Enabled = true
            else
                Player.Character.UpperTorso.Beam8.Enabled = false
                AllHive.Hive8.Highlight.Enabled = false
                AllHive.Hive8.Platform.Highlight.Enabled = false
                AllHive.Hive8.Platform.Up.Indecator.Button.Enabled = false
            end

        end
    end)
end
Remote.HiveButtonCheck.OnServerEvent:Connect(ButtonServerCheckPlayer)
Remote.HiveSpawnSlot.OnServerEvent:Connect(HiveAndSlot)
--Remote.HiveOwner.OnServerEvent:Connect(CheckButton)
Remote.HiveSettings.OnServerEvent:Connect(HiveSettingsBasic)

return HiveServer