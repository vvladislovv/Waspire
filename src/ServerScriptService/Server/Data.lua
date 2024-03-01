local Data = {}

local Players = game:GetService("Players")
local CopyTable = require(game.ReplicatedStorage.Libary.CopyTable)

local Remotes = game.ReplicatedStorage:WaitForChild("Remote")
--local Modules = game.ReplicatedStorage:WaitForChild("Modules")
--local Items = require(Modules.Items)

Data.PlayerData = {}

function Data.new(Player)
	local PData = {}
	PData.Loaded = false

	PData.BaseFakeSettings = {
		HiveOwner = "",
		HiveNumber = 0,
	}
	
	PData.BaseSettings = { 
		Coin = 0,
        Pollen = 0,
        Tutorial = false
	}

    PData.TotalItems = {
        TotalQuestAll = 0,
        CoinTotal = 0,
        PollenTotal = 0,
        WaspTotal = 0,
    }

    PData.Hive = {
        Slot = 35,
		SlotMax = 35,
        WaspInSlot = 0,
        RolingWasp = 0,
    }

    PData.BoostPollen  = {
        ['Banana'] = 100
    }

	PData.QuestTaskNPC = {}
	
    PData.QuestNPC = {
        ['Vladislov'] = {
		NowQuest = false, --* Новый квест
		Complish = false, --* Настоящий квест
		QuestEvent = false, --* Праздничный квест
		TotalQuest = 1 --* Всего
		},
        ['Bread'] = {NowQuest = false, Complish = false, QuestEvent = false, TotalQuest = 1, NoQuset = false},
		['Snail'] = {NowQuest = false,Complish = false, QuestEvent = false, TotalQuest = 1, NoQuset = false},
    }

	PData.Inventory = {
		['Waspik Egg'] = {
            Amount = 1
        }
	}

	PData.Equipment = {
        Tool = "",
        Bag = "",
		Boot = "",
        Belt = "",
        Hat = "",
        Gloves = "",
        Shoulders = "" -- Наплечники
	}

	PData.Bagers = {
		['Pollen'] = {
            Rank = 1,
            Amount = 0
        },

        ['Coin'] = {
            Rank = 1,
            Amount = 0
        }
	}

    PData.Settings = { 
        Sound = false
        
    }
	
	function PData:Update(key, value)
		PData[key] = value
		Remotes.DataUpdate:FireClient(Player,key,value)
	end
	
	Data.PlayerData[Player.Name] = PData
	return PData
end

function Data:Get(Player)
	if game:GetService("RunService"):IsServer() then
		return Data.PlayerData[Player.Name]
	else
		return Remotes.GetDataSave:InvokeServer()
	end
end

local AutoSaves = {}

local MainKey = 'DataMainServerAlifa12'
local ClientKey = 'DataMainClientAlifa12'

local DataStore2 = require(game.ServerScriptService.DataStore2)

function LoadData(Client)
	DataStore2.Combine(MainKey, ClientKey)
	local PData = Data.new(Client)
	local DataStorage = DataStore2(ClientKey, Client):GetTable(PData)
	PData = GetDataFromDataStorage(Client, DataStorage)
	PData.Loaded = true
	print(PData)
	AutoSaves[Client.Name] = Client
end

function SaveData(client, PData)
	DataStore2(ClientKey, client):Set(CopyTable:CopyWithoutFunctions(PData))
	print(PData)
end 

function GetDataFromDataStorage(Client, DataStorage)
	local PData = Data:Get(Client)

	for i,v in pairs(DataStorage.BaseSettings) do
		PData.BaseSettings[i] = DataStorage.BaseSettings[i]
	end

	for i,v in pairs(DataStorage.Hive) do
		PData.Hive[i] = DataStorage.Hive[i]
	end

	for i,v in pairs(DataStorage.TotalItems) do
		PData.TotalItems[i] = DataStorage.TotalItems[i]
	end

	for i,v in pairs(DataStorage.BoostPollen) do
		PData.BoostPollen[i] = DataStorage.BoostPollen[i]
	end

	for i,v in pairs(DataStorage.Settings) do
		PData.Settings[i] = DataStorage.Settings[i]
	end

	for i,v in pairs(DataStorage.Inventory) do
		PData.Inventory[i] = DataStorage.Inventory[i]
	end

	for i,v in pairs(DataStorage.Equipment) do
		PData.Equipment[i] = DataStorage.Equipment[i]
	end

    for i,v in pairs(DataStorage.QuestNPC) do
		PData.QuestNPC[i] = DataStorage.QuestNPC[i]
	end

    for i,v in pairs(DataStorage.Bagers) do
		PData.Bagers[i] = DataStorage.Bagers[i]
	end
	return PData
end
do
	Players.PlayerAdded:Connect(LoadData)
	Players.PlayerRemoving:Connect(function(Client)
		SaveData(Client, Data:Get(Client))
		AutoSaves[Client.Name] = nil
	end)
	--Players.PlayerRemoving:Connect(function(Client) SaveData(Client, Data:Get(Client)) AutoSaves[Client.Name] = nil end)

	game.ReplicatedStorage.Remote.GetDataSave.OnServerInvoke = function(client)
		local PData = Data:Get(client)
		return PData
	end
end

local TotalDelta = 0
task.spawn(function()
	while task.wait(1) do
		TotalDelta += 1
		if TotalDelta > 3 then
			TotalDelta = 0
			for _, Player in pairs(AutoSaves) do
				local PData = Data:Get(Player)
				SaveData(Player, PData)
			end
		end
	end
end)

return Data
