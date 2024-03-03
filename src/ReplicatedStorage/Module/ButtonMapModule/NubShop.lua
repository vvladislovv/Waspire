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
local CameraNow = 0
local WailStoper = false
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local NubShop = {}


function LeftShopButton()
    CameraNow -= 1
--print(CameraNow)
    if CameraNow > #CameraFolder.CameraShopMini:GetChildren() then
        CameraNow -= 1
    end

    if CameraNow == 0 then
        CameraNow = 11
    end
    TweenService:Create(Cam,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play() 
end

function RightShopButton()
    CameraNow += 1
   -- print(CameraNow)
    if CameraNow > #CameraFolder.CameraShopMini:GetChildren() then
        CameraNow = 1
    end
    if CameraNow == 12 then
        CameraNow = 1
    end
    TweenService:Create(Cam,TweenInfo.new(0.2, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = CameraFolder.CameraShopMini["Cam"..CameraNow].CFrame}):Play()
end

function GetItemShop()
    local TableItemsShop = {}
    
    for _, ItemsIndex in pairs(ItemsModule.StartShop) do
        TableItemsShop = ItemsIndex
    end
    print(TableItemsShop)
    return TableItemsShop
end


function NubShop:OpenShop()
    task.wait()
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
            UI.Shop.Visible = true
            Cam.CameraType = Enum.CameraType.Scriptable
            Cam.CFrame = CameraFolder.CameraShopMini.Cam1.CFrame
            GetItemShop()
            _G.PData.BaseFakeSettings.OpenShopPlayer = true
        elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
            Cam.CameraType = Enum.CameraType.Custom
            CameraNow = 1
            UI.Shop.Visible = false
            _G.PData.BaseFakeSettings.OpenShopPlayer = false
        end
    end)
end



function NubShop:UpdateShop()
    
end


ButtonRight.ButtonDown.TextButton.MouseButton1Click:Connect(RightShopButton)
ButtonLeft.ButtonDown.TextButton.MouseButton1Click:Connect(LeftShopButton)


return NubShop