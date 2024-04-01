local PollenLeaderboard = {} -- TemplatePollen
local DSS = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local LeaderboardFolder = workspace.Leaderboard.Pollen
local DataSave = require(script.Parent.Parent.Server.Data)
local LeaderStore = DSS:GetOrderedDataStore("TestAlifa135223")
local AdminTable = require(game.ReplicatedStorage.Libary.TableUser)
local UtilsModule = require(game.ReplicatedStorage.Libary.Utils)
local Holder = LeaderboardFolder.GuiTwoBoard1.SurfaceGui:WaitForChild("Holder")
local Template = game.ReplicatedStorage.Assert.LeaderboadrTemp:WaitForChild("TemplatePollen")

local function ClearBoard()
	for _, T in pairs(Holder:GetChildren()) do
		if not T:IsA("UIListLayout") then
			T:Destroy()
		end
	end
end
local function UpdateBoard()
	local Pages = LeaderStore:GetSortedAsync(false, 100)
	local TopTen = Pages:GetCurrentPage()
	ClearBoard()
	task.wait()
	for Key, Value in pairs(TopTen) do
		local PlayerName = Players:GetNameFromUserIdAsync(Value.key)
        local content = game.Players:GetUserThumbnailAsync(Value.key, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		if Value.value >= 0 then
			local NewPlayer = Template:Clone()
			NewPlayer.Parent = Holder
            NewPlayer.Frame.ImageLabel.Image = content
            NewPlayer.Frame.Player.Text = PlayerName
			NewPlayer.Frame.Rank.Text = "#"..Key
			NewPlayer.Frame.Value.Text = UtilsModule:CommaNumber(Value.value)
		end
	end
end

task.spawn(function()
	while true do
		for _, Player in pairs(Players:GetPlayers()) do
			local PData = DataSave:Get(Player)
			local Currency = PData.BaseSettings.Pollen
            print('fff')
            if AdminTable.NameUserAdmin[Player.Name] == true then
				LeaderStore:SetAsync(Player.UserId,0)
			else
				LeaderStore:SetAsync(Player.UserId, math.floor(Currency))
			end

		end
		UpdateBoard()
		task.wait(20)
	end
end)
return PollenLeaderboard