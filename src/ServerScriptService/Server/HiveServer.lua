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

function CheckButton(Player, IndexPlatform, AllHive) -- Кнопка(локал)
    task.spawn(function()
        while true do
            task.wait()
            --print(IndexPlatform.Owner.Value)
            
            if AllHive.Hive1.Owner.Value ~= "" then
                AllHive.Hive1.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive1.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive2.Owner.Value ~= "" then
                AllHive.Hive2.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive2.Platform.Up.Indecator.Button.Enabled = false
            end
            
            if AllHive.Hive3.Owner.Value ~= "" then
                AllHive.Hive3.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive3.Platform.Up.Indecator.Button.Enabled= false
            end

            if AllHive.Hive4.Owner.Value ~= "" then
                AllHive.Hive4.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive4.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive5.Owner.Value ~= "" then
                AllHive.Hive5.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive5.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive6.Owner.Value ~= "" then
                AllHive.Hive6.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive6.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive7.Owner.Value ~= "" then
                AllHive.Hive7.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive7.Platform.Up.Indecator.Button.Enabled = false
            end

            if AllHive.Hive8.Owner.Value ~= "" then
                AllHive.Hive8.Platform.Up.Indecator.Button.Enabled = true
            else
                AllHive.Hive8.Platform.Up.Indecator.Button.Enabled = false
            end

        end
    end)
end

Remote.HiveOwner.OnServerEvent:Connect(CheckButton)
Remote.HiveSettings.OnServerEvent:Connect(HiveSettingsBasic)

return HiveServer