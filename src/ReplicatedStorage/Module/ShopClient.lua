local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character:WaitForChild('HumanoidRootPart')
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NubShop = require(script.Parent.ButtonMapModule.NubShop)
local CocnShop = require(script.Parent.ButtonMapModule.CocoonShop)
local ShopCooking = require(script.Parent.ButtonMapModule.ShopCooking)
local GoCave = require(script.Parent.ButtonMapModule.TeleportCave)

local Remote = ReplicatedStorage:WaitForChild('Remote')
local Libary = ReplicatedStorage.Libary
local TweenModule = require(Libary.TweenService)
local ButtonFolder = workspace.ButtonMap
local ShopCleint = {}

local TableSettings = {
    ShopMini = false,
    ShopCocoon = false,
    ShopCooking = false,
    GoCave = false,
}
_G.PData = Remote.GetDataSave:InvokeServer()




function ButtonDistation(Distation, Button, indexShop)
    task.wait()
    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        if indexShop.Name == "ShopMiniButton" then
            --print('ffff')
                TableSettings.ShopMini = true
                NubShop:OpenShop(TableSettings.ShopMini)
        elseif indexShop.Name == "ShopCocoon" then
                TableSettings.ShopCocoon = true
                CocnShop:OpenShop(TableSettings.ShopCocoon)
        elseif indexShop.Name == "ShopCooking" then
                TableSettings.ShopCooking = true
                ShopCooking:OpenShop(TableSettings.ShopCooking)
        elseif indexShop.Name == "QuestMosquito"then
            ButtonQuestMosquito()
        elseif indexShop.Name == "ShopSnail" then
            ButtonShopSnail()
        elseif indexShop.Name == "GoCave" then
            TableSettings.GoCave = true
            GoCave:OpenShop(TableSettings.GoCave)
        elseif indexShop.Name == "WatherEvent" then
            print('ff')
        elseif indexShop.Name == "QusetOpenLocation" then
            --print('aa')
        end
    elseif Distation > 10 then
        TweenModule:SizeBasicButtonClose(Button)
        if indexShop.Name == "ShopMiniButton" then
            TableSettings.ShopMini = false
            NubShop:OpenShop(TableSettings.ShopMini)
        elseif indexShop.Name == "ShopCocoon" then
            TableSettings.ShopCocoon = false
            CocnShop:OpenShop(TableSettings.ShopCocoon)
        elseif indexShop.Name == "ShopCooking" then
            TableSettings.ShopCooking = false
            ShopCooking:OpenShop(TableSettings.ShopCooking)
        elseif indexShop.Name == "GoCave" then
            TableSettings.GoCave = false
            GoCave:OpenShop(TableSettings.GoCave)
        end
        
    end
end



function ButtonShopEgg()
    print('ButtonShopEgg')
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