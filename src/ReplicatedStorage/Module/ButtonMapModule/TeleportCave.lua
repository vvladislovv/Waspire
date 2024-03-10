local TeleportCave = {}

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local FrameBlackTeleport = UI.FrameBlackTeleport
local TextTeleport = FrameBlackTeleport.TextLabel
local CameraFolder = workspace.CameraFolder
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CamOriginal = nil
local PlayerScript = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local TweenModule = require(game.ReplicatedStorage.Libary.TweenService)

local Controls = PlayerModule:GetControls()
local ItemsModule = require(script.Parent.Parent.itemsShop)
local Cam = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local ShopMiniClient =  false

function TeleportCave:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
        --print(ShopMiniClient)
    elseif not ShopMini then
        ShopMiniClient = false
    end
end
function TweenCamera(Camera1,Camera2)
	local Teewin = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut,0)

	Cam.CameraType = Enum.CameraType.Scriptable
	Cam.CFrame = Camera1.CFrame

	local Tween = TweenService:Create(Cam, Teewin, {CFrame = Camera2.CFrame})
	Tween:Play()
	--task.wait(6)
	--Camera.CameraType = Enum.CameraType.Custom
end

function GuiStart()
    task.spawn(function()
        while true do
            task.wait()
            TextTeleport.Text = "Teleporting."
            task.wait(0.3)
            TextTeleport.Text = "Teleporting.."
            task.wait(0.3)
            TextTeleport.Text = "Teleporting..."
            task.wait(0.3)
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                FrameBlackTeleport.Visible = true
                --CamOriginal = Cam.CFrame
                --Controls:Disable()
                Cam.CameraType = Enum.CameraType.Scriptable
                --TweenService:Create(FrameBlackTeleport.TextLabel, TweenInfo.new(0.8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
                TweenService:Create(Cam, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CaveGo.Cam2.CFrame}):Play()
                TweenModule:TransparencyBlack(FrameBlackTeleport)
                GuiStart()
                TweenCamera(CameraFolder.CaveGo.Cam1,CameraFolder.CaveGo.Cam2)
            --[[elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
				_G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                Controls:Enable()
                UI.Shop.Visible = false]]
            end
        end
    end
end)

return TeleportCave