local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character:WaitForChild('HumanoidRootPart')
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NubShop = require(script.Parent.ButtonMapModule.NubShop)
local CocnShop = require(script.Parent.ButtonMapModule.CocoonShop)

local Remote = ReplicatedStorage:WaitForChild('Remote')
local Libary = ReplicatedStorage.Libary
local TweenModule = require(Libary.TweenService)
local ButtonFolder = workspace.ButtonMap
local ShopCleint = {}

local TableSettings = {
    ShopMini = false,
    ShopCocoon = false,
}
_G.PData = Remote.GetDataSave:InvokeServer()




function ButtonDistation(Distation, Button, indexShop)
    task.wait()
    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        if indexShop.Name == "ShopMiniButton" then
            TableSettings.ShopMini = true
            NubShop:OpenShop(TableSettings.ShopMini)
        elseif indexShop.Name == "ShopCocoon" then
                TableSettings.ShopCocoon = true
                CocnShop:OpenShop(TableSettings.ShopCocoon)
        elseif indexShop.Name == "ShopCooking" then
            ButtonShopCooking()
        elseif indexShop.Name == "QuestMosquito"then
            ButtonQuestMosquito()
        elseif indexShop.Name == "ShopSnail" then
            ButtonShopSnail()
        elseif indexShop.Name == "GoCave" then
            ButtonGoCave()
        end
    elseif Distation > 10 then
        TweenModule:SizeBasicButtonClose(Button)
        if indexShop.Name == "ShopMiniButton" then
            TableSettings.ShopMini = false
            NubShop:OpenShop(TableSettings.ShopMini)
        elseif indexShop.Name == "ShopCocoon" then
            TableSettings.ShopCocoon = true
            NubShop:OpenShop(TableSettings.ShopCocoon)
        end
        
    end
end



function ButtonShopEgg()
    print('ButtonShopEgg')
end

function ButtonShopCooking()
   print('ButtonShopCooking')
end

function ButtonQuestMosquito()
   print('ButtonQuestMosquito')
end

function ButtonShopSnail()
    print('ButtonShopSnail')
end

function ButtonGoCave()
    print('ButtonGoCave')
end

for _, indexShop in next, ButtonFolder:GetChildren() do
    task.spawn(function()
        while true do
            task.wait()
           -- print(indexShop)
            local DistationButton = (indexShop.Position - HumRootPart.Position).Magnitude
            ButtonDistation(DistationButton,indexShop.Button,indexShop)
        end
    end)
end

return ShopCleint