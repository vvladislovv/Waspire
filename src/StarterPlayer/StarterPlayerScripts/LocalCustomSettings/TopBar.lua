local TopBar = {}
local IconModule = require(game.ReplicatedStorage.Libary.Icon)
local IconCollector = require(game.ReplicatedStorage.Libary.Icon.IconController)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')

local EvunkHub = 15979397263

local UIIcon = IconModule.new() --! Отключение всей гуи
	:setLabel("UIs")
	:bindEvent("selected", function()
		for _, index in next, PlayerGui:GetChildren() do
		if index.Name == "ScreenGui" then
			index.Enabled = false
		end
	end
	end)
	:bindEvent("deselected", function()
		print('UI On')
		for _, index in next, PlayerGui:GetChildren() do
		index.Enabled = true
	end
	end)

local WaspierIcon = IconModule.new() -- ! Записать в дату
	:setLabel('The Waspier')
	:bindEvent("selected", function()
		print('Auto Play')
	end)
	:bindEvent("deselected", function()
		print('No Auto Play')
	end)


local EvinkIcon = IconModule.new()
	:setLabel("Evink hub")
	:bindEvent("selected", function()
		game:GetService('TeleportService'):Teleport(EvunkHub)
	end)

return TopBar
