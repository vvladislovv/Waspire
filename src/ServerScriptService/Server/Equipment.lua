-- Дописать скрипт баг парфель на бошке

local EquipmentModule = {}

local PhysicsService = game:GetService("PhysicsService")
local Player = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remote")
local Items = ReplicatedStorage:FindFirstChild("Assert").ItemsFolder
local Data = require(script.Parent.Data)
local PlayerGroup = PhysicsService:RegisterCollisionGroup("p")
PhysicsService:CollisionGroupSetCollidable("p","p", false)

function NoCollide(Model) -- Отключение колизии
    Model:WaitForChild("Humanoid")
    Model:WaitForChild("HumanoidRootPart")
    Model:WaitForChild("Head")
    for _, value in pairs(Model:GetChildren()) do
        if value:IsA("BasePart") then
           -- print(value)
            value.CollisionGroup = "p"
        end
    end
end

function EquipmentModule:LoadItems(Player, PData, Character)
    NoCollide(Character)
    local Humanoid = Character:FindFirstChild("Humanoid")

    EquipmentModule:EquipItemsGame(Character, "Boot", PData)
    EquipmentModule:EquipItemsGame(Character, "Parachute", PData)
    EquipmentModule:EquipItemsGame(Character, "RGuard", PData)
    EquipmentModule:EquipItemsGame(Character, "LGuard", PData)
    EquipmentModule:EquipItemsGame(Character, "Glove", PData)
    EquipmentModule:EquipItemsGame(Character, "Hat", PData)
    EquipmentModule:EquipItemsGame(Character, "Tool", PData)
    EquipmentModule:EquipItemsGame(Character, "Bag", PData)
    EquipmentModule:EquipItemsGame(Character, "Belt", PData)


    Humanoid.Died:Connect(function()
        local Character = Player.CharacterAdded:Wait()
        local PData = Data:Get(Player)
        --! Оповищение, что рюкзак пуст
        PData.BaseSettings.Pollen = 0
        EquipmentModule:LoadItems(Player, PData, Character)
    end)
end

function EquipmentModule:StartSysmes()
    Player.PlayerAdded:Connect(function(Player)
        task.wait(2)
        local Character = workspace:WaitForChild(Player.Name)
        local PData = Data:Get(Player)
        EquipmentModule:LoadItems(Player, PData, Character)
    end)
end

function EquipmentModule:EquipItemsGame(Character, TypeItem, PData)
    local Humanoid = Character:WaitForChild("Humanoid")
    --print(Character)
    if PData.Equipment[TypeItem] then
        local Item = PData.Equipment[TypeItem]
        local ItemObj1
        local ItemObj2

        if Item ~= "" then
           if TypeItem == "Boot" then
                if Item ~= "" then
                    ItemObj1 = Items:WaitForChild(TypeItem)[Item.."L"]:Clone() 
                    ItemObj2 = Items:WaitForChild(TypeItem)[Item.."R"]:Clone()
                    Humanoid:AddAccessory(ItemObj1)
                    Humanoid:AddAccessory(ItemObj2)
                    ItemObj1.Name = "Boot"
                    ItemObj2.Name = "Boot"
                    end
            elseif TypeItem == "Glove" then
                if Item ~= "" then
                    ItemObj1 = Items:WaitForChild(TypeItem)[Item.."L"]:Clone()
                    ItemObj2 = Items:WaitForChild(TypeItem)[Item.."R"]:Clone()
                    Humanoid:AddAccessory(ItemObj1)
                    Humanoid:AddAccessory(ItemObj2)
                    ItemObj1.Name = "Glove"
                    ItemObj2.Name = "Glove"
                    end
                else

                ItemObj1 = Items:WaitForChild(TypeItem)[Item]:Clone() -- папки в RS с буквой S без этого не видно
                
                if ItemObj1:IsA("Accessory") then
--						
                        for _,v in pairs(ItemObj1:GetChildren()) do
                            if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Union") or v:IsA("BasePart") then
                                v.Anchored = false
                                v.CanCollide = false
                                v.Massless = true
                            end
                        end

                    if TypeItem == "Bag" then
                        ItemObj1.Name = "Bag"
                        Humanoid:AddAccessory(ItemObj1)

                    elseif TypeItem == "Parachute" then
                        ItemObj1.Name = "Parachute"
                        Humanoid:AddAccessory(ItemObj1)

                    elseif TypeItem == "Hat" then
                        ItemObj1.Name = "Hat"
                        Humanoid:AddAccessory(ItemObj1)
                        
                    elseif TypeItem == "LGuard" then
                        ItemObj1.Name = "LGuard"
                        Humanoid:AddAccessory(ItemObj1)
                    elseif TypeItem == "RGuard" then
                        ItemObj1.Name = "RGuard"
                        Humanoid:AddAccessory(ItemObj1)
                        
                    elseif TypeItem == "Belt" then
                        ItemObj1.Name = "Belt"
                        Humanoid:AddAccessory(ItemObj1)
                    end
                elseif ItemObj1:IsA("Tool") then -- Копирование копания
                            --local CollectScript = AssertSS.Tools:Clone()
                            --CollectScript.Parent = ItemObj1
                            ItemObj1.Parent = Character
                            ItemObj1.Name = "Tool"
                        else
                            ItemObj1.Parent = Character
                end
           end
        end
    end
end

return EquipmentModule