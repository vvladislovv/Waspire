local EggShop = {}
local UserInputService = game:GetService("UserInputService")
local ShopMiniClient = false
local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local ShopCoccon = UI.ShopCoccon
local ButtonBuy = ShopCoccon.ButtonBuy
local FrameGlobule = ShopCoccon.FrameGlobule

local Cam = game.Workspace.CurrentCamera
local originalcframe = Cam.CFrame
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
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(Cam, TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CameraShopCocon.Cam1.CFrame}):Play()
                --Cam.CFrame = CameraFolder.CameraShopCocon.Cam1.CFrame
                GetItemShop()
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                -- Дописать на отдачу камеры по красоте
                --Cam.CameraType = Enum.CameraType.Custom
                --TweenService:Create(CameraFolder.CameraShopCocon.Cam1, TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = originalcframe}):Play()
                Cam.CameraType = Enum.CameraType.Custom
			    Cam.CameraSubject = Humanoid
                CameraNow = 1
                UI.ShopCoccon.Visible = false              
            end
        end
    end
end)

return EggShop