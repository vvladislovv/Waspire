local ClientScript = game.ReplicatedStorage.Module

for _, index in next, ClientScript:GetDescendants() do
	if index:IsA('ModuleScript') then
		require(index)
		print(index)
	end
end