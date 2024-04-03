local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remote = ReplicatedStorage:WaitForChild('Remote')

local Zone = require(ReplicatedStorage.Zone)
local Data = require(script.Parent.Data)
local TableMosnter = require(ReplicatedStorage.Module.ItemsGame)

local MonsterZone = workspace.MonsterZone
local PlayerMobs = workspace.PlayerMobs
local Billboard = ReplicatedStorage.Assert.BillboardGui
local Config = ReplicatedStorage.Assert.Configuration
local MosterModule = {}

function TokenSpawn(Player, Amt, tableReward,tableReward2,StartVector3, amountofitems,Arclength)

    local AngleBetweenInDegrees = 360/amountofitems
	local AngleBetweenInRad = math.rad(AngleBetweenInDegrees)
	local Radius = Arclength/AngleBetweenInRad +2
	local tab = {}
	local currentangle = 0  
	for num = 1, amountofitems do
		currentangle +=  AngleBetweenInRad
		local z = math.cos(currentangle)*Radius
		local x = math.sin(currentangle)*Radius 
		local vector3 = StartVector3 + Vector3.new(x,0,z) -- Указать парт которые остаеться и это будет точка радиуса
		table.insert(tab,vector3)
		
		local PartClone = ReplicatedStorage.Assert.Token:Clone()
		PartClone.Parent = workspace.TokenSpawn
		PartClone.Transparency = 1
		PartClone.Position = vector3
		TweenService:Create(PartClone, TweenInfo.new(1,Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Transparency = 0}):Play()
        Remote.Token.FireClient(Player,PartClone)
        PartClone.Touched:Connect(function(hit)
            local Player = game.Players.GetPlayerFromCharacter(hit.Parent)
            local PData = Data:Get(Player)
            if Player then
                PData[tableReward.Type][tableReward2] += Amt
            end
        end)
    end
	return tab
end

function MosterModule.GetRewards(Mob, Player, Field)
    local PData = Data:Get(Player)
    local RewardNumber = 0
    local TokenRadios = 0
    for i,v in pairs(TableMosnter.Monster['Ladibag'].Reward) do
        RewardNumber += 1
        if i ~= "Battle Points" then
            local Chance = math.random(1,10000)
            if Chance <= v.Chance then
                local Amt
                if type(v.Amt) == "table" then -- Проверка на таблицу
                    Amt = math.random(1, #v.Amt)
                else
                    Amt = v.Amt + math.random(1, #v.Amt)
                end
                if RewardNumber == 3 then
                    TokenRadios = 6
                    TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber > 3 then
                    TokenRadios = 8
                    TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber > 8 then
                    TokenRadios = 10
                    TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber < 15 then
                    TokenRadios = 12
                    TokenSpawn(Player,Amt,v,i, Mob, RewardNumber. TokenRadios)
                end
            end
        else
            print('fff')
        end
    end
end

function MosterModule.WaspAttack()
    
end

function UpdateGui(Mob, Configuration, Player, Field)
    Configuration.HP.Changed:Connect(function(Health)
        if Mob and Mob.PrimaryPart then
            Mob.PrimaryPart:FindFirstChild("BG").Bar.TextLabel.Text = "HP:"..Health
            Mob.PrimaryPart:FindFirstChild("BG").Bar.FB.Size = UDim2.new(Configuration.HP.Value / Configuration.MaxHP.Value,0,1,0)
            
            if Health <= 0 then
                local PData = Data:Get(Player)
                if PData.BaseFakeSettings.Attack then
                    PData.BaseFakeSettings.Attack = false
                    MosterModule.GetRewards(Mob, Player, Field) -- Написать

                    Mob:FindFirstChild('PositionObj'):Destroy()
                    if Mob.PimaryPart then
                        Mob.PimaryPart:FindFirstChild('BG').Enabled = false
                    end
                    task.wait(0.5)
                    Mob:Destroy()
                end
            end
        end
    end)
end

function MosterModule.CreateMobs(Player, Field)
    local PData = Data:Get(Player)
    for i, indexTable in pairs(TableMosnter.Monster) do
        if  indexTable.Field == Field then
            local Mob = ReplicatedStorage.Mobs:FindFirstChild(TableMosnter.Monster:FindFirstChild(Field)):Clone()

            if not PlayerMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
                local Folder = Instance.new("Folder", PlayerMobs)
                Folder.Name = Player.Name
            end

            PData.BaseFakeSettings.Attack = true
            -- Обновить в гуи

            local Configuration = Config:Clone()
            Configuration.Parent = Mob
            Configuration.Player.Value = Player.Name
            Configuration.HP.Value = TableMosnter.Monster[Field].HP
            Configuration.MaxHP.Value = TableMosnter.Monster[Field].HP
            Configuration.Level.Value = TableMosnter.Monster[Field].Level


            local BillboardGui = Billboard:Clone()
            BillboardGui.Parent = Mob.PimaryPart
            BillboardGui.MobName.Text = Mob.Name.." (Lvl "..Configuration.Level.Value..")"
            BillboardGui.Bar.TextLabel.Text = "HP:"..Configuration.MaxHP.Value
            BillboardGui.Bar.FB.Size = UDim2.new(1,0,1,0)
            BillboardGui.Name = "BG"
            BillboardGui.StudsOffsetWorldSpace = Vector3.new(0,Mob.PrimaryPart.Size.Y, 0)
            BillboardGui.AlwaysOnTop = true
            BillboardGui.MaxDistance = TableMosnter.Monster[Field].SettingsMobs.Dist * 1.5

            if Mob.Name ~= "" then
                MosterModule.WaspAttack() -- Написать 
            end

            UpdateGui(Mob, Configuration, Player, Field) -- Дописать
        end
    end

end

function MosterModule:StartZone()
    for _, v in next, MonsterZone:GetChildren() do
        local Zone = Zone.new(v)

        Zone.playerEntered:Connect(function(Player) -- * Start
            local PData = Data:Get(Player)
            if not PData.TimerTable[v.Name] then
                MosterModule.CreateMobs(Player, v)
            elseif PData.TimerTable[v.Name].Time then
                if PData.TimerTable[v.Name].Time - os.time() <= 0 then
                    MosterModule.CreateMobs(Player, v)
                end
            end
        end)


        Zone.playerExited:Connect(function(Player)
            local PData = Data:Get(Player)
            PData.BaseFakeSettings.Attack = false
            PData.BaseFakeSettings.Attack = nil

            -- Сделать обновление для гуи
            if #PlayerMobs:FindFirstChild(Player.Name):GetChildren() > 0 then
                for i, indexMobs in next, PlayerMobs:FindFirstChild(Player.Name):GetChildren() do
                    task.spawn(function()
                        if indexMobs and indexMobs:FindFirstChild('PositionObj') then
                            indexMobs:FindFirstChild('PositionObj'):Destroy()
                            if indexMobs.PimaryPart then
                                indexMobs.PimaryPart:FindFirstChild('BG').Enabled = false
                            end
                            task.wait(0.5)
                            indexMobs:Destroy()
                        end
                    end)
                end
            end
        end)
    end
end
MosterModule.GetRewards()

return MosterModule