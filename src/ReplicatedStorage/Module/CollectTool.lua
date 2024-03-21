local CollectTool = {}
print('ffasdfasd')
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemsGame = require(ReplicatedStorage.Module.ItemsGame)
local Remote = ReplicatedStorage:WaitForChild('Remote')

local FolderAnimTool = ReplicatedStorage.AnimFolder.ToolAnim -- ! Добавить
local FolderStamps = ReplicatedStorage.FolderStamps
local StampsWorksSpawn = workspace.StampsWorksSpawn

_G.PData = Remote.GetDataSave:InvokeServer()

local FlowerTabs = {}

function CheckFieldFlower()
    for i, Field in next, workspace.FieldsGame:GetChildren() do
        for iv, FlowerField in next, Field:GetChildren() do
            table.insert(FlowerTabs,FlowerField)
        end
    end
end


function CollecltUsePollen(Player) 
    local Character = Player.CharacterAdded and Player.CharacterAdded:Wait()
    local Pollen = _G.PData.BaseSettings.Pollen
    local Tool = _G.PData.Equipment.Tool
    local Capacity = _G.PData.BaseSettings.Capacity

    if Character and Pollen and Capacity then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local PrimaryPart = Character.PrimaryPart
        if Pollen < Capacity then
            if PrimaryPart then
                for i, v in pairs(ItemsGame.Equipment.Tool) do
                    print(i)
                    print(v)
                end
                local rayBalls



                task.delay(0.1, function()
                    if rayBalls then
                        rayBalls:Destroy()
                    end
                end)

            end
        end
    end
end

for i, v in pairs(ItemsGame.Equipment.Tool) do
    if _G.PData.Equipment.Tool  == i then
        local StapmsClone = FolderStamps:FindFirstChild(v.Stamps) -- получили
        print(StapmsClone)
        print(i)
        print(v)
    else
        warn('no')
    end

end

task.spawn(CheckFieldFlower)
--Remote.UseCollect.OnServerEvent(CollecltUsePollen)

return CollectTool