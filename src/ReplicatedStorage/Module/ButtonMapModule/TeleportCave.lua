local TeleportCave = {}

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local FrameBlackTeleport = UI.FrameBlackTeleport
local TextTeleport = FrameBlackTeleport.TextLabel
local CameraFolder = workspace.CameraFolder
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerScript = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local TweenModule = require(game.ReplicatedStorage.Libary.TweenService)
local TeleportCaveW = workspace.TeleportMap.Cave
local Controls = PlayerModule:GetControls()
local Cam = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local ShopMiniClient =  false
local TeleportPerent = false
local OldTeleport = nil

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

function Teleport() 
    if not TeleportPerent then
        Player.Character.HumanoidRootPart.CFrame =  TeleportCaveW.CFrame + Vector3.new(0,3,0)
        TeleportPerent = true
        task.wait(4)
        Cam.CameraType = Enum.CameraType.Custom
        TweenModule:OffTransparencyBlack(FrameBlackTeleport)
        TweenService:Create(TextTeleport, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.126, 0,0.8, 0)}):Play()
        task.wait(2)
        FrameBlackTeleport.Visible = false
        TeleportPerent = false
    end
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
			if input.KeyCode == Enum.KeyCode.E then
                FrameBlackTeleport.Visible = true
                Cam.CameraType = Enum.CameraType.Scriptable
                TweenService:Create(TextTeleport, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.126, 0,0.42, 0)}):Play()
                TweenService:Create(Cam, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.CaveGo.Cam2.CFrame}):Play()
                TweenModule:TransparencyBlack(FrameBlackTeleport)
                GuiStart()
                TweenCamera(CameraFolder.CaveGo.Cam1,CameraFolder.CaveGo.Cam2)
                Teleport()
            end
        end
    end
end)

return TeleportCave