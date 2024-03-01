local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local Data = require(script.Parent.Data)
local HiveFolder = workspace.Hive

local HiveServer = {}


function HiveSettingsBasic(Player, IndexPlatform) -- Косание локал(Изменения на севере)
    local PData = Data:Get(Player)
    if PData.BaseFakeSettings.HiveOwner == "" then
        IndexPlatform.Owner.Value = Player.Name
        IndexPlatform.NamePlayerHive.BillboardGui.TextLabel.Text = Player.Name
        PData.BaseFakeSettings.HiveOwner = Player.Name
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end

end

function BeanCheckGame()
    local HiveFolder = workspace.Hive

    local function CheckHive(Char) -- переписать на склиент
        --for _, AllHive in next, HiveFolder:GetChildren() do
            if HiveFolder.Hive1.Owner.Value == "" then
                Char.UpperTorso.Beam1.Enabled = true
            else
                Char.UpperTorso.Beam1.Enabled = false
            end

            if HiveFolder.Hive2.Owner.Value == "" then
                Char.UpperTorso.Beam2.Enabled = true
            else
                Char.UpperTorso.Beam2.Enabled = false
            end

            if HiveFolder.Hive3.Owner.Value == "" then
                Char.UpperTorso.Beam3.Enabled = true
            else
                Char.UpperTorso.Beam3.Enabled = false
            end

            if HiveFolder.Hive4.Owner.Value == "" then
                Char.UpperTorso.Beam4.Enabled = true
            else
                Char.UpperTorso.Beam4.Enabled = false
            end

            if HiveFolder.Hive5.Owner.Value == "" then
                Char.UpperTorso.Beam5.Enabled = true
            else
                Char.UpperTorso.Beam5.Enabled = false
            end

            if HiveFolder.Hive6.Owner.Value == "" then
                Char.UpperTorso.Beam6.Enabled = true
            else
                Char.UpperTorso.Beam6.Enabled = false
            end

            if HiveFolder.Hive7.Owner.Value == "" then
                Char.UpperTorso.Beam7.Enabled = true
            else
                Char.UpperTorso.Beam7.Enabled = false
            end

            if HiveFolder.Hive8.Owner.Value == "" then
                Char.UpperTorso.Beam8.Enabled = true
            else
                Char.UpperTorso.Beam8.Enabled = false
            end

            
        --end
    end

    print('fff')
    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            CheckHive(char)
        end)
    end)
end

function CheckButton(Player, IndexPlatform, AllHive) -- переписать на склиент
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
BeanCheckGame()
Remote.HiveOwner.OnServerEvent:Connect(CheckButton)
Remote.HiveSettings.OnServerEvent:Connect(HiveSettingsBasic)

return HiveServer