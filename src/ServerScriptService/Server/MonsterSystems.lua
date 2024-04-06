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

function MosterModule.TokenSpawn(Player, Amt, tableReward,tableReward2,StartVector3, amountofitems,Arclength)

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
                    MosterModule.TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber > 3 then
                    TokenRadios = 8
                    MosterModule.TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber > 8 then
                    TokenRadios = 10
                    MosterModule.TokenSpawn(Player,Amt,v,i, Mob, RewardNumber, TokenRadios)
                elseif RewardNumber < 15 then
                    TokenRadios = 12
                    MosterModule.TokenSpawn(Player,Amt,v,i, Mob, RewardNumber. TokenRadios)
                end
            end
        else
            -- Добавить к бейджу
        end
    end
end

function WaitUntilReached(Mob, Magnituder)
    if Mob and Mob:FindFirstChild("Body") then
		repeat task.wait()
            if not Mob or not Mob:FindFirstChild("Body") or not Mob:FindFirstChild("PositionObj") then 
                break
            end
		until (Mob.Body.Position - Mob.PositionObj.Position).Magnitude <= (Magnituder or 0.7)
	else
		return
	end
end

function RotationToPlayer(Mob, Rotation, Player)
    task.spawn(function()
        while Mob do
            task.wait()
            if Rotation then
                if workspace:WaitForChild(Player.Name) then
                    local Character = workspace:FindFirstChild(Player.Name)
                    if Mob:FindFirstChild('Body') then
                        local targetPosition = Character.PrimaryPart.Position
                        local CurrentPosition = Mob.Body.Position
                        local lookVector = (targetPosition - CurrentPosition).unit -- Position Mob and Character
                        local upVector = Vector3.new(0,0,0)
                        --task.wait(1)
                        --Mob:FindFirstChild("Body").BodyGyro.CFrame = CFrame.new(Mob.Body.Position, Character.PrimaryPart.Position) * CFrame.Angles(0, math.rad(180), 0)
                        
                        --Mob.Body.CFrame = CFrame.new(CurrentPosition, targetPosition) * CFrame.Angles(0, math.rad(180), 0)
                        Mob:MoveTo(Character.PrimaryPart.Position)
                    else
                        break
                    end
                else
                    Mob:Destroy()
                    break
                end
            end
        end
    end)
end

function MosterModule.MobsAttack(Mob, Rotation, Player, Field, Attack)
    --RotationToPlayer(Mob, Rotation, Player)

    local Character = game.Workspace:FindFirstChild(Player.Name)
    local PositionObj = Mob:FindFirstChild("PositionObj")
    local Flowers = workspace.FieldsGame[Field.Name]:GetChildren() -- получаем цветы
    local Flower = Flowers[math.random(1, #Flowers)]
    local PData = Data:Get(Player)
    local EnemyHumanoid = Mob:FindFirstChild('EnemyHumanoid')
    local MaxSpeed = TableMosnter.Monster[Mob.Name].SettingsMobs.Speed
    print(EnemyHumanoid)
    local Distance = (Mob.Body.Position - Character.PrimaryPart.Position).Magnitude

    task.spawn(function()
        while true do
            task.wait()
            if Distance > 5 then -- только моб, а сам хуманоин нет
				--EnemyHumanoid:MoveTo(Character.PrimaryPart.Position)
			else
				print('fff')
            end
        end
    end)

end


function MosterModule.UpdateGui(Mob, Configuration, Player, Field)
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
    task.spawn(function()
        local PData = Data:Get(Player)
        local Rotation = true
        local Attack = false
        for i, index in next, Field:GetChildren() do
			if index.Name == "Pos1" or index.Name == "Pos2" then
                local Mob = ReplicatedStorage.Mobs:FindFirstChild(Field.Monster.Value):Clone()
                local MaxNumber 
                if not PlayerMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
                    local Folder = Instance.new("Folder", PlayerMobs)
                    Folder.Name = Player.Name
                end

            PData.BaseFakeSettings.Attack = true
            -- Обновить в гуи

            local Configuration = Config:Clone()
            Configuration.Parent = Mob
            Configuration.Player.Value = Player.Name
            Configuration.HP.Value = TableMosnter.Monster[Mob.Name].HP
            Configuration.MaxHP.Value = TableMosnter.Monster[Mob.Name].HP
            Configuration.Level.Value = TableMosnter.Monster[Mob.Name].Level

			Mob.Parent = PlayerMobs:FindFirstChild(Player.Name)
            --print(index)
			if not Field.Pos1.Spawn.Value then
                Mob:MoveTo(Field:FindFirstChild("Pos1").WorldPosition)
                Field.Pos1.Spawn.Value = true
            elseif not Field.Pos2.Spawn.Value then
                Mob:MoveTo(Field:FindFirstChild("Pos2").WorldPosition)
                Field.Pos2.Spawn.Value = true
            end

            local BillboardGui = Billboard:Clone()
            BillboardGui.Parent = Mob.PrimaryPart
            BillboardGui.MobName.Text = Mob.Name.." (Lvl "..Configuration.Level.Value..")"
            BillboardGui.Bar.TextLabel.Text = "HP:"..Configuration.MaxHP.Value
            BillboardGui.Bar.FB.Size = UDim2.new(1,0,1,0)
            BillboardGui.Name = "BG"
            BillboardGui.StudsOffsetWorldSpace = Vector3.new(0,Mob.PrimaryPart.Size.Y, 0)
            BillboardGui.AlwaysOnTop = true
            BillboardGui.MaxDistance = TableMosnter.Monster[Mob.Name].SettingsMobs.Dist * 1.5

            MosterModule.MobsAttack(Mob, Rotation, Player, Field, Attack)

            MosterModule.UpdateGui(Mob, Configuration, Player, Field) -- Дописать

            end
        end
    end)
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
                            if indexMobs.PrimaryPart then
                                indexMobs.PrimaryPart:FindFirstChild('BG').Enabled = false
                                v.Pos1.Spawn.Value = false
                                v.Pos2.Spawn.Value = false
                            end
                            task.wait(0.1)
                            indexMobs:Destroy()
                        end
                    end)
                end
            end
        end)
    end
end
--MosterModule.GetRewards()

return MosterModule