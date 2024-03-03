local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character:WaitForChild('HumanoidRootPart')
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NubShop = require(script.Parent.ButtonMapModule.NubShop)

local Remote = ReplicatedStorage:WaitForChild('Remote')
local Libary = ReplicatedStorage.Libary
local TweenModule = require(Libary.TweenService)
local ButtonFolder = workspace.ButtonMap
local ShopCleint = {}
_G.PData = Remote.GetDataSave:InvokeServer()

function ButtonDistation(Distation, Button, indexShop) -- Баг с системой 
    task.wait()
    if Distation < 10 then
        TweenModule:SizeBasicButtonOpen(Button)
        if indexShop.Name == "ShopMiniButton" and Distation < 10 then
            NubShop:OpenShop()
        elseif indexShop.Name == "ShopEgg" then
            ButtonShopEgg()
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