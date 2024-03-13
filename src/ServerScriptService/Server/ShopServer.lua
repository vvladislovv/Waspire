local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local DataSave = require(script.Parent.Data)

local ShopServer = {}


function BuyItems(plr, ItemsName, ItemsCost, ItemsType)
    local PData = DataSave:Get(plr)
    PData.BaseSettings.Coin -= ItemsCost
end

function BuyItemsEqument(plr, ItemsName, ItemsCost, ItemsType)
    local PData = DataSave:Get(plr)
    print(PData.EquipmentShop)
    print(PData.Equipment)
    PData.Equipment[ItemsType] = ItemsName
    PData.EquipmentShop[ItemsType.."s"][ItemsName] = true
    PData:Update('EquipmentShop', PData.EquipmentShop)
    PData:Update('Equipment', PData.Equipment)
    print(PData.EquipmentShop)
end

Remote.EqumentItemsShop.OnServerEvent:Connect(BuyItemsEqument)
Remote.ShopBuy.OnServerEvent:Connect(BuyItems)

return ShopServer