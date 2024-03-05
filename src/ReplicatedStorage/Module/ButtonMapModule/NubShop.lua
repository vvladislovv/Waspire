-- Дописать Покупку и проверку на вещь

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ButtonBuy = UI.Shop.ButtonBuy
local ButtonLeft = UI.Shop.ButtonLeft
local ButtonRight = UI.Shop.ButtonRight
local FrameGlobule = UI.Shop.FrameGlobule
local CameraFolder = workspace.CameraFolder
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cam = game.Workspace.CurrentCamera
local ItemsModule = require(script.Parent.Parent.itemsShop)
local CameraNow = 1
local MaxOrder = 0
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local NubShop = {}

local ShopMiniClient =  false

function LeftShopButton()
     if CameraNow >= MaxOrder then
         CameraNow = 1
     end
     CameraNow += 1
     TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play()
end

function RightShopButton()
    CameraNow -= 1
    if CameraNow <= 0 then
        CameraNow = MaxOrder
    end
    --print(CameraNow)
    TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play() 
end

function TweenIngredients(Ingredients)
    if Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(0.093, 0,-0.2, 0)}):Play() 
    elseif not Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(2, 0,-0.2, 0)}):Play() 
    end
end

function GetItemShop()
    local Ingredients = false
    for _, ItemsTable in pairs(ItemsModule.StartShop) do
        MaxOrder += 1
        task.spawn(function()
            while true do
                task.wait()
                if ItemsTable.Type == "Bag" then
                    if ItemsTable.OrderShop == 8 and CameraNow == 8 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 9 and CameraNow == 9 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 10 and CameraNow == 10 then
                        Ingredients = false
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 11 and CameraNow == 11 then
                        Ingredients = false
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                    --print('fff')
                elseif ItemsTable.Type == "Tool" then
                    if ItemsTable.OrderShop == 1 and CameraNow == 1 then
                        Ingredients = false
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"    
                    elseif ItemsTable.OrderShop == 2 and CameraNow == 2 then
                        Ingredients = false
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 3 and CameraNow == 3 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 4 and CameraNow == 4 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Hat" then
                    if ItemsTable.OrderShop == 5 and CameraNow == 5 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Boot" then
                    if ItemsTable.OrderShop == 6 and CameraNow == 6 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Belt" then
                    if ItemsTable.OrderShop == 7 and CameraNow == 7 then
                        Ingredients = true
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                end

            end
        end)
    end
end

function NubShop:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
            if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                UI.Shop.Visible = true
                Cam.CameraType = Enum.CameraType.Scriptable
                Cam.CFrame = CameraFolder.CameraShopMini.Cam1.CFrame
                GetItemShop()
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                Cam.CameraType = Enum.CameraType.Custom
                CameraNow = 1
                UI.Shop.Visible = false
                
            end
        end
    end
end)



ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)


return NubShop