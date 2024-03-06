local ShopCooking = {}
local ShopMiniClient = false
local Player = game:GetService("Players").LocalPlayer
local PlayerScript = Player:WaitForChild("PlayerScripts")
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ButtonBuy = UI.Shop.ButtonBuy
local ButtonLeft = UI.Shop.ButtonLeft
local ButtonRight = UI.Shop.ButtonRight
local FrameGlobule = UI.Shop.FrameGlobule

local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

local ItemsModule = require(script.Parent.Parent.itemsShop)
local CameraFolder = workspace.CameraFolder
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local CameraNow = 1
local MaxOrder = 0
_G.PData = Remote.GetDataSave:InvokeServer()

function LeftShopButton()
    CameraNow -= 1
   if CameraNow <= 0 then
    CameraNow = MaxOrder
   end
   --print(CameraNow)
   TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopCooking["Cam"..CameraNow].CFrame}):Play() 
end

function RightShopButton()
    CameraNow += 1
    if CameraNow >= MaxOrder then
        TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..MaxOrder].CFrame}):Play()
        CameraNow = 1
    end
    TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopCooking["Cam"..CameraNow].CFrame}):Play()
end

function GetItemShop()
    local Ingredients = false
    for _, ItemsTable in pairs(ItemsModule.CookingShop) do
        MaxOrder += 1
        task.spawn(function()
            while true do
                task.wait()
                if ItemsTable.Type == "Inventory" then
                    FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                    FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                    FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                end
            end
        end)
    end
end

function ShopCooking:OpenShop(ShopMini)
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
            print('fff')
            if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                UI.Shop.Visible = true
                CamOriginal = Cam.CFrame
                Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopCooking.Cam1.CFrame}):Play()
                GetItemShop()

                ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
                ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)

            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                CameraNow = 1
                Controls:Enable()
                UI.Shop.Visible = false        
            end
        end
    end
end)






return ShopCooking