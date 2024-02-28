local Server = game.ServerScriptService.Server

for _, index in next, Server:GetDescendants() do
    if index:IsA('ModuleScript') then
        require(index)
    end
end
