-- Дописать Покупку и проверку на вещь

-- 12.03.24 
-- Надо как то придумать проверку ингридиентов на вещь, исправить баг на ингридиенты(хуй знает как это сделать)

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
local ItemsTableGame = require(script.Parent.Parent.ItemsFoodGame)

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
local ItemsTablert = {}

local NubShop = {}

function LeftShopButton()
     if CameraNow == MaxOrder then
        CameraNow = 1
     else
        CameraNow += 1
     end
    GetItemShop(CameraNow)
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

function TweenIngredients(Ingredients)
    if Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(0.093, 0,-0.2, 0)}):Play() 
    elseif not Ingredients then
        TweenService:Create(FrameGlobule.ItemsProductAdd,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(2, 0,-0.2, 0)}):Play() 
    end
end

function BuyItems(ItemsTable,Ingredient)
    if _G.PData.BaseSettings.Coin == ItemsTable.Cost then
        ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[1]
        ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant2[2]
        ButtonBuy.ButtonDown.TextButton.Text = "Equip"
    else
        
        if Ingredient then
            for NumberNamePredmet, QuantItems in pairs(ItemsTable.Ingredients) do
                for PDataNumberIndex, ItemsQuantPData in pairs(_G.PData.Inventory) do
                    if NumberNamePredmet == PDataNumberIndex then
                        for vi, items in next, FrameGlobule.ItemsProductAdd.UpFrame:GetChildren() do
                            if _G.PData.Inventory[NumberNamePredmet] >= QuantItems then
                                
                               -- FrameGlobule.ItemsProductAdd.UpFrame.Item1.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant2[1]
                            else
                                --FrameGlobule.ItemsProductAdd.UpFrame.Item1.TextLabel.TextColor3 = TableColorNofficalMSG.Colors.Variant1[1]
                            end
                        end
                    end
                end
            end
        end

        ButtonBuy.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[1]
        ButtonBuy.ButtonDown.BackgroundColor3 = TableColorNofficalMSG.Colors.Variant1[2]
        ButtonBuy.ButtonDown.TextButton.Text = "No Equip"
    end
end

function updateItemDisplay(ItemsTable, showIngredients)
    BuyItems(ItemsTable, showIngredients)
    TweenIngredients(showIngredients)
    FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
    FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
    FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
end

function AddPredmetItems(NameItems, tableIndex, ItemsCheckIngredient)
    for i, IndexTable in pairs(ItemsTableGame.FoodGame) do
        for index, value in next, FrameGlobule.ItemsProductAdd.UpFrame:GetChildren() do
            if NameItems == i then
                --table.insert(ItemsTable,ItemsCheckIngredient,NameItems)
                print(ItemsTablert)
                if value:IsA('ImageLabel') then
                    if not FrameGlobule.ItemsProductAdd.UpFrame:FindFirstChild(NameItems) and table.find(ItemsTablert,NameItems) then
                        table.clear(ItemsTablert)
                        local ItemsGuiAdd = ReplicatedStorage.Assert.ItemsGuiAdd:Clone()
                        ItemsGuiAdd.Parent = FrameGlobule.ItemsProductAdd.UpFrame
                        ItemsGuiAdd.Name = NameItems
                        ItemsGuiAdd.TextLabel.Text = tableIndex
                    else
                        value:Destroy()
                    end
                end
            end
        end
    end
end

function GetItemShop(CameraNow)
    local showIngredients = false
    local ItemsCheckIngredient = 0
    for _, ItemsTable in pairs(ItemsModule.StartShop) do
        if CameraNow == ItemsTable.OrderShop then
            if ItemsTable.Ingredients ~= nil then
                for i, tableIndex in pairs(ItemsTable.Ingredients) do
                    ItemsCheckIngredient += 1
					if ItemsCheckIngredient > 0 then
						AddPredmetItems(i, tableIndex,ItemsCheckIngredient)
					end
                    if not table.find(ItemsTablert,i) then
                        table.insert(ItemsTablert,ItemsCheckIngredient,i)
                    end
                end
                showIngredients = true
            else
                showIngredients = false
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
                GetItemShop(CameraNow)
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