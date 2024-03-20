local GoCaveEnd = {}

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UI = PlayerGui:WaitForChild('UI')
local FrameBlackTeleport = UI.FrameBlackTeleport
local TextTeleport = FrameBlackTeleport.TextLabel
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerScript = Player:WaitForChild("PlayerScripts")
local TweenModule = require(game.ReplicatedStorage.Libary.TweenService)
local Cam = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()
local ShopMiniClient =  false
local TeleportPerent = false

function GoCaveEnd:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
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
        Player.Character.HumanoidRootPart.CFrame = workspace.Map.SpawnFolder.SpawnLocation.CFrame + Vector3.new(0,3,0)
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
                TweenModule:TransparencyBlack(FrameBlackTeleport)
                GuiStart()
                Teleport()
            end
        end
    end
end)

return GoCaveEnd