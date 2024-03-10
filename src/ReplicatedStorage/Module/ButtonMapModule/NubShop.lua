-- Дописать Покупку и проверку на вещь(G)

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
local CamOriginal = nil
local PlayerScript = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
local ItemsModule = require(script.Parent.Parent.itemsShop)
local CameraNow = 1
local MaxOrder = 11
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local ShopMiniClient =  false

local TableColorNofficalMSG = {
    Colors = {
        Variant1 = {[1] = Color3.fromRGB(106, 24, 27), [2] = Color3.fromRGB(136, 31, 33)}, -- Yes
        Variant2 = {[1] = Color3.fromRGB(61, 186, 8), [2] = Color3.fromRGB(55, 166, 7)}, -- No
    }
}

local NubShop = {}

function LeftShopButton()
     if CameraNow == MaxOrder then
        CameraNow = 1
     else
        CameraNow += 1
     end
    print(CameraNow)
    TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play()
end

function RightShopButton()
    CameraNow -= 1
    print(CameraNow)
    if CameraNow <= 0 then
        CameraNow = MaxOrder
    end
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
    local TableIndex = nil
    local function BuyItems(ItemsTable,Ingredient)
		--print(TableIndex)
        if _G.PData.BaseSettings.Coin == ItemsTable.Cost then
            ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[1]
            ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[2]
            ButtonBuy.ButtonDown.TextButton.Text = "Equip"
        else
            
            if Ingredient then -- придумать релизацию. Надо сделать чтобы находил и проверял если ли такая штука, и также если сколько нужно на пакупку
                -- потом отправка на покупку, там проверка фейк или нет, и покупка в пдате
                for NumberNamePredmet, QuantItems in pairs(ItemsTable.Ingredients) do
                    for PDataNumberIndex, ItemsQuantPData in pairs(_G.PData.Inventory) do
                        print(table.find(_G.PData.Inventory,NumberNamePredmet))
                        if NumberNamePredmet == PDataNumberIndex then
                            if ItemsQuantPData.Amount >= QuantItems then
                                print("asdfasdf")
                            else
                                warn("Error")
                            end
                        else
                            warn("Error")
                        end 
                    end
                end
                if TableIndex ~= nil then
                    FrameGlobule.ItemsProductAdd.UpFrame.Item1.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                else
                    
                end
            else

            end

            ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[1]
            ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[2]
            ButtonBuy.ButtonDown.TextButton.Text = "No Equip"
        end
    end

    local Ingredients = false

    for _, ItemsTable in pairs(ItemsModule.StartShop) do
        task.spawn(function()
            while true do
                task.wait()
                if ItemsTable.Type == "Bag" then
                    if ItemsTable.OrderShop == 8 and CameraNow == 8 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 9 and CameraNow == 9 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 10 and CameraNow == 10 then
                        Ingredients = false
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 11 and CameraNow == 11 then
                        Ingredients = false
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                    --print('fff')
                elseif ItemsTable.Type == "Tool" then
                    if ItemsTable.OrderShop == 1 and CameraNow == 1 then
                        Ingredients = false
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"    
                    elseif ItemsTable.OrderShop == 2 and CameraNow == 2 then
                        Ingredients = false
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 3 and CameraNow == 3 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    elseif ItemsTable.OrderShop == 4 and CameraNow == 4 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Hat" then
                    if ItemsTable.OrderShop == 5 and CameraNow == 5 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Boot" then
                    if ItemsTable.OrderShop == 6 and CameraNow == 6 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
                        TweenIngredients(Ingredients)
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                elseif ItemsTable.Type == "Belt" then
                    if ItemsTable.OrderShop == 7 and CameraNow == 7 then
                        Ingredients = true
                        BuyItems(ItemsTable,Ingredients)
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
            print('aaa')
			if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                CameraNow = 1
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                UI.Shop.Visible = true
                CamOriginal = Cam.CFrame
                Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopMini.Cam1.CFrame}):Play()
                GetItemShop()
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                CameraNow = 1
				_G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                Controls:Enable()
                UI.Shop.Visible = false
                
            end
        end
    end
end)

ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)

return NubShop