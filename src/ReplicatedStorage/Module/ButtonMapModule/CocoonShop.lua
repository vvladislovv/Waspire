local EggShop = {}

local ShopMiniClient = false
local Player = game:GetService("Players").LocalPlayer
local PlayerScript = Player:WaitForChild("PlayerScripts")
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ShopCoccon = UI.ShopCoccon
local ButtonBuy = ShopCoccon.ButtonBuy
local FrameGlobule = ShopCoccon.FrameGlobule

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

function EggShop:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end


function GetItemShop()
    local Ingredients = false
    for _, ItemsTable in pairs(ItemsModule.EggShop) do
        MaxOrder += 1
        task.spawn(function()
            while true do
                task.wait()
                if ItemsTable.Type == "Inventory" then
                    if ItemsTable.OrderShop == 1 and CameraNow == 1 then
                        FrameGlobule.ItemsName.ItemsNameUp.TextLabel.Text = ItemsTable.Name
                        FrameGlobule.FrameTextItems.FrameTextItemsUp.TextLabel.Text = ItemsTable.Description
                        FrameGlobule.ItemsCost.ItemsCostUp.TextLabel.Text = ItemsTable.Cost.." Coin"
                    end
                end
            end
        end)
    end
end


UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
            if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                UI.ShopCoccon.Visible = true
                CamOriginal = Cam.CFrame
                Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopCocon.Cam1.CFrame}):Play()
                --Cam.CFrame = CameraFolder.CameraShopCocon.Cam1.CFrame
                GetItemShop()
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                CameraNow = 1
                Controls:Enable()
                UI.ShopCoccon.Visible = false
                --Cam.CameraType = Enum.CameraType.Custom       
            end
        end
    end
end)

return EggShop