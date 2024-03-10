local ShopCooking = {}
local ShopMiniClient = false
local Player = game:GetService("Players").LocalPlayer
local PlayerScript = Player:WaitForChild("PlayerScripts")
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ButtonBuy = UI.ShopCooking.ButtonBuy
local ButtonLeft = UI.ShopCooking.ButtonLeft
local ButtonRight = UI.ShopCooking.ButtonRight
local FrameGlobule = UI.ShopCooking.FrameGlobule

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
local MaxOrder = 9
_G.PData = Remote.GetDataSave:InvokeServer()

function LeftShopButton()
    if CameraNow == MaxOrder then
       CameraNow = 1
    else
       CameraNow += 1
    end
   print(CameraNow)
   TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopCooking["Cam"..CameraNow].CFrame}):Play()
end

function RightShopButton()
   CameraNow -= 1
   print(CameraNow)
   if CameraNow <= 0 then
       CameraNow = MaxOrder
   end
   TweenService:Create(Cam,TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopCooking["Cam"..CameraNow].CFrame}):Play()
end

function GetItemShop()
    local Ingredients = false
    for _, ItemsTable in pairs(ItemsModule.CookingShop) do
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
            if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                CameraNow = 1
                UI.ShopCooking.Visible = true
                CamOriginal = Cam.CFrame
                Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopCooking.Cam1.CFrame}):Play()
                GetItemShop()
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                CameraNow = 1
                Controls:Enable()
                UI.ShopCooking.Visible = false        
            end
        end
    end
end)

ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)





return ShopCooking