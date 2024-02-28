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

function CheckButton(Player, IndexPlatform) -- Кнопка(локал)
    task.spawn(function()
        while true do
            task.wait()
            if  IndexPlatform.Owner.Value ~= "" then
                IndexPlatform.Platform.Up.Indecator.Button.Enabled = true
            else
                IndexPlatform.Platform.Up.Indecator.Button.Enabled = false
            end
        end
    end)
end

Remote.HiveOwner.OnServerEvent:Connect(CheckButton)
Remote.HiveSettings.OnServerEvent:Connect(HiveSettingsBasic)

return HiveServer