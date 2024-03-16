local CameraHeadServer = {}

game.ReplicatedStorage.Remote.Look.OnServerEvent:Connect(function(player, neckCFrame)
	for key, value in pairs(game.Players:GetChildren()) do
		if value ~= player and (value.Character.Head.Position - player.Character.Head.Position).Magnitude < 10 then
			game.ReplicatedStorage.Remote.Look:FireClient(value, player, neckCFrame)
		end
	end
end)

return CameraHeadServer
