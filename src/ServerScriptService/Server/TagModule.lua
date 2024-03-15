local TagModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage") --You can change this to ServerStorage for more security.
local nametag = ReplicatedStorage.Assert.NameTag

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)

		local Head = char:WaitForChild("Head")
		local newtext = nametag:Clone() --Cloning the text.
		local uppertext = newtext.UpperText
		local humanoid = char.Humanoid

		humanoid.DisplayDistanceType = "None"

		--Main Text
		newtext.Parent = Head
		newtext.Adornee = Head
		uppertext.Text = player.Name
	end)
end)


return TagModule