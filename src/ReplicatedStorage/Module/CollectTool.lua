local CollectTool = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemsGame = require(ReplicatedStorage.Module.ItemsGame)
local Remote = ReplicatedStorage:WaitForChild('Remote')

local FolderAnimTool = ReplicatedStorage.AnimFolder.ToolAnim -- ! Добавить
local FolderStamps = ReplicatedStorage.FolderStamps
local StampsWorksSpawn = workspace.StampsWorksSpawn

local canDig = false

_G.PData = Remote.GetDataSave:InvokeServer()

local FlowerTabs = {}

function CheckFieldFlower()
    for i, Field in next, workspace.FieldsGame:GetChildren() do
        for iv, FlowerField in next, Field:GetChildren() do
            table.insert(FlowerTabs,FlowerField)
        end
    end
end

function CollectFlower(StapmsClone)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = FlowerTabs

    local posA = StapmsClone.PrimaryPart.Position
    local posB = StapmsClone.PrimaryPart.Position -Vector3.new(0,5,0)
    local direction = posB - posA

    local raycastResult = workspace:Raycast(posA, direction,params)
    
    if raycastResult and raycastResult.Instance then
        local Flower = raycastResult.Instance
        if Flower:FindFirstChild('FlowerID') then
            canDig = true
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
        local PrimaryPartChar = Character.PrimaryPart
        if Pollen < Capacity then
            if PrimaryPartChar then
                for i, v in pairs(ItemsGame.Equipment.Tool) do
                    if _G.PData.Equipment.Tool  == i then
                        local StapmsClone = FolderStamps:FindFirstChild(v.Stamps) -- получили
                        StapmsClone.Parent = StampsWorksSpawn
                        StapmsClone.PrimaryPart.CFrame = PrimaryPartChar.CFrame

                        task.delay(0.1, function()
                            if StapmsClone then
                                StapmsClone:Destroy()
                            end
                        end)

                        CollectFlower(StapmsClone)

                    end
                end
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
Remote.UseCollect.OnServerEvent(CollecltUsePollen)

return CollectTool