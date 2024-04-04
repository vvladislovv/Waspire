local MonsterSystems = require(script.MonsterSystems)
local Equipment = require(script.Equipment)
MonsterSystems:StartZone()
--Equipment:StartSysmes()
local Server = game.ServerScriptService.Server

for _, index in next, Server:GetDescendants() do
    if index:IsA('ModuleScript') then
        require(index)
    end
end
