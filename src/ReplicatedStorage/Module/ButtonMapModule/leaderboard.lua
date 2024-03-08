local leaderboard = {}
local Player = game:GetService("Players").LocalPlayer
local mouse = Player:GetMouse()
local PlayerScript = Player:WaitForChild("PlayerScripts")
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local UserInputService = game:GetService("UserInputService")
local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local CameraClick = 1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
local CameraFolder = workspace.CameraFolder
local LeaderboardFolder = workspace.Leaderboard
local target = mouse.Target
local ShopMiniClient = false
local rotateAmount = 50

function leaderboard:OpenShop(ShopMini)
    task.wait()
    if ShopMini then
        ShopMiniClient = true
    elseif not ShopMini then
        ShopMiniClient = false
    end
end

local function enable(camera, camPart)   
    game:GetService("RunService"):BindToRenderStep("CameraLookAtMouse", Enum.RenderPriority.Camera.Value + 1, function()
        TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = camPart.CFrame * CFrame.Angles(
            -- Divide ViewSize values by 2 so the screen is centered when the mouse is at the middle, not at the top left corner
            math.rad((mouse.Y - mouse.ViewSizeY/2) / (mouse.ViewSizeY/2) * -rotateAmount),
            math.rad((mouse.X - mouse.ViewSizeX/2) / (mouse.ViewSizeX/2) * -rotateAmount),
            math.rad(0))}):Play()
    end)
end

local function disable()
    game:GetService("RunService"):UnbindFromRenderStep("CameraLookAtMouse")
    Cam.CameraType = Enum.CameraType.Custom
end

UserInputService.InputBegan:Connect(function(input, GPE) -- появление
    if not GPE then
        if ShopMiniClient then
            if input.KeyCode == Enum.KeyCode.E and not _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = true
                Controls:Disable()
                CamOriginal = Cam.CFrame
                Cam.CameraType = Enum.CameraType.Scriptable
                --TweenService:Create(Cam, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam1.CFrame}):Play()
                enable(Cam, CameraFolder.LeadeBoard.Cam1)
                
                print(target)
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
                task.wait(0.1)
                CamOriginal = nil
                disable()
                Controls:Enable()
            end
        end
    end
end)



return leaderboard