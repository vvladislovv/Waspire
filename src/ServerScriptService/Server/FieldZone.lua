local FieldRegist = {}
local Zone = require(script.Parent.Parent.Zone)
local DataSave = require(game.ServerScriptService.Server.Data)

for _, v in next, workspace.FieldsGame:GetChildren() do
    local Zone = Zone.new(v)
    Zone.playerEntered:Connect(function(Player)
        local PData = DataSave:Get(Player)
        PData.BaseFakeSettings.FieldVars = v.Name
        PData.BaseFakeSettings.FieldVarsOld = v.Name
        --PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = DataSave:Get(Player)
        PData.BaseFakeSettings.FieldVars = ""
        --PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)
end

return FieldRegist