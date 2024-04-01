local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')

local Zone = require(ReplicatedStorage.Zone)
local Data = require(script.Parent.Data)
local TableMosnter = require(ReplicatedStorage.Module.ItemsGame)

local MonsterZone = workspace.MonsterZone
local PlayerMobs = workspace.PlayerMobs
local Billboard = ReplicatedStorage.Assert.BillboardGui
local Config = ReplicatedStorage.Assert.Configuration
local MosterModule = {}


function UpdateGui(Mob, Congig, Player, Field)
    Config.HP.Changed:Connect(function(Health)
        if Mob and Mob.PrimaryPart then
            Mob.PrimaryPart:FindFirstChild("BG").Bar.TextLabel.Text = "HP:"..Health
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
            Configuration.Level.Value = TableMosnter.Monster[Field].Level


            local BillboardGui = Billboard:Clone()
            BillboardGui.Parent = Mob.PimaryPart
            BillboardGui.MobName.Text = Mob.Name.." (Lvl "..Configuration.Level.Value..")"
            BillboardGui.Bar.TextLabel.Text = "HP:"..Configuration.HP.Value
            BillboardGui.Bar.FB.Size = UDim2.new(1,0,1,0)
            BillboardGui.Name = "BG"
            BillboardGui.StudsOffsetWorldSpace = Vector3.new(0,Mob.PrimaryPart.Size.Y, 0)
            BillboardGui.AlwaysOnTop = true
            BillboardGui.MaxDistance = TableMosnter.Monster[Field].SettingsMobs.Dist * 1.5

            if Mob.Name ~= "" then
                MosterModule.WaspAttack() -- Написать 
            end

            UpdateGui() -- Дописать
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


return MosterModule