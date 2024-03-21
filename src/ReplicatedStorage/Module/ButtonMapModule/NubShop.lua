-- Дописать Покупку и проверку на вещь

-- 12.03.24 
-- Сделать индекс, красивое появление и тажке больше и меньше на кнопки оставить задел на звук

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local PlayerScript = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

local ButtonBuy = UI.Shop.ButtonBuy
local ButtonLeft = UI.Shop.ButtonLeft
local ButtonRight = UI.Shop.ButtonRight
local FrameGlobule = UI.Shop.FrameGlobule
local CameraFolder = workspace.CameraFolder

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()

local ItemsModule = require(script.Parent.Parent.itemsShop)
local ItemsTableGame = require(script.Parent.Parent.ItemsGame)

local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local CameraNow = 1
local MaxOrder = 11
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
        GetItemShop(CameraNow)
    end
    TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play()
end

function RightShopButton()
    CameraNow -= 1
    GetItemShop(CameraNow)
    if CameraNow <= 0 then
        CameraNow = MaxOrder
    end
    TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play() 

end

function MouseButtonEqument(ItemsName, ItemsCost, ItemsType)
    task.wait()
    Remote.EqumentItemsShop:FireServer(ItemsName, ItemsCost, ItemsType)
end

function MouseButtonBuy(ItemsName, ItemsCost, ItemsType)
    task.wait()
    Remote.ShopBuy:FireServer(ItemsName,ItemsCost, ItemsType)
end

function TweenIngredients(Ingredients)
    if Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(0.093, 0,-0.2, 0)}):Play() 
    elseif not Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(2, 0,-0.2, 0)}):Play() 
    end
end

function updateItemDisplay(ItemsTable, showIngredients, NameItems, tableIndex)
    TweenIngredients(showIngredients)
    FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
    FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
    FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
end

function GetItemShop(CameraNow)
    local showIngredients = false
    for _, ItemsTable in pairs(ItemsModule.StartShop) do
        if CameraNow == ItemsTable.OrderShop then
            if ItemsTable.Ingredients ~= nil then

                for _, indexFrame in pairs(FrameGlobule.ItemsProductAdd.UpFrame:GetChildren()) do
                    if indexFrame:IsA("ImageLabel") then
                        indexFrame:Destroy()
                    end
                end

                for i, tableIndex in pairs(ItemsTable.Ingredients) do
                    showIngredients = true
                    local ItemsGuiAdd = ReplicatedStorage.Assert.ItemsGuiAdd:Clone()
                    ItemsGuiAdd.Parent = FrameGlobule.ItemsProductAdd.UpFrame
                    ItemsGuiAdd.Name = i
                    ItemsGuiAdd.TextLabel.Text = "x"..tableIndex

                    if _G.PData.BaseSettings.Coin == ItemsTable.Cost and _G.PData.EquipmentShop[ItemsTable.Name] == true and  _G.PData.Inventory[i] >= tableIndex then
                        ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                        ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[2]
                        ButtonBuy.ButtonDown.TextButton.Text = "Equip"
                        ButtonBuy.ButtonDown.TextButton.MouseButton1Click:Connect(function()
                            MouseButtonBuy(ItemsTable.Name, ItemsTable.Cost)
                        end)
                    elseif _G.PData.BaseSettings.Coin == ItemsTable.Cost and _G.PData.EquipmentShop[ItemsTable.Name] ~= true and  _G.PData.Inventory[i] >= tableIndex then
                        ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                        ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[2]
                        ButtonBuy.ButtonDown.TextButton.Text = "Purchase"
                        ButtonBuy.ButtonDown.TextButton.MouseButton1Click:Connect(function()
                            MouseButtonEqument(ItemsTable.Name, ItemsTable.Cost, ItemsTable.Type)
                        end)
                    elseif _G.PData.BaseSettings.Coin ~= ItemsTable.Cost and _G.PData.EquipmentShop[ItemsTable.Name] ~= true and  _G.PData.Inventory[i] ~= tableIndex then
                        ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[1]
                        ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[2]
                        ButtonBuy.ButtonDown.TextButton.Text = "No Equip"
                    end

                    if _G.PData.Inventory[i] == tableIndex then
                        ItemsGuiAdd.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                    elseif not _G.PData.Inventory[i] then
                        ItemsGuiAdd.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant1[1]
                    elseif _G.PData.Inventory[i] > tableIndex then
                        ItemsGuiAdd.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                    else
                        ItemsGuiAdd.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant1[1]
                    end


                end
            end
            updateItemDisplay(ItemsTable, showIngredients)
        end 
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
                CameraNow = 1
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                UI.Shop.Visible = true
                CamOriginal = Cam.CFrame
                Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopMini.Cam1.CFrame}):Play()
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


coroutine.wrap(function()
	for _, btn in next, UI.Shop:GetChildren() do
        if btn.Name == "ButtonBuy" or btn.Name == "ButtonLeft" or btn.Name == "ButtonRight" then
            local buttonSizeX = btn.Size.X.Scale
            local buttonSizeY = btn.Size.Y.Scale

            btn.MouseEnter:Connect(function()
                local newSizeX = (buttonSizeX + 0.01) --// Change this to what you like
                local newSizeY = (buttonSizeY + 0.01) --// Change this to what you like

                local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(btn, info, {Size = UDim2.new(newSizeX, 0, newSizeY, 0)}):Play()
            end)

            btn.MouseLeave:Connect(function()
                local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                TweenService:Create(btn, info, {Size = UDim2.new(buttonSizeX, 0, buttonSizeY, 0)}):Play()
            end)
        end
    end
end)()


ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)

return NubShop