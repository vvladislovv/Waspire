local leaderboard = {}
local Player = game:GetService("Players").LocalPlayer
local mouse = Player:GetMouse()
local PlayerScript = Player:WaitForChild("PlayerScripts")
local UserInputService = game:GetService("UserInputService")
local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local CameraClick = false
local CameraClick2 = false
local TweenService = game:GetService("TweenService")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
local CameraFolder = workspace.CameraFolder
local LeaderboardFolder = workspace.Leaderboard
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

local function enable(camPart)
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
    TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
    task.wait(0.5)
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
                enable(CameraFolder.LeadeBoard.Cam1)
                print('fff')
                TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam1.CFrame}):Play()
                CameraClick = true
                CameraClick2 = true
                LeaderboardFolder.Coin.ClickDetector.MouseClick:Connect(function()
                    game:GetService("RunService"):UnbindFromRenderStep("CameraLookAtMouse")
                    if CameraClick and _G.PData.BaseFakeSettings.OpenShopPlayer then
                        print('fff')
                        TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam2.CFrame}):Play()
                        CameraClick = false
                    elseif not CameraClick and _G.PData.BaseFakeSettings.OpenShopPlayer then
                        enable(CameraFolder.LeadeBoard.Cam1)
                        print('aaa')
                        TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam1.CFrame}):Play()
                        CameraClick = true
                    end
                end)

                LeaderboardFolder.Pollen.ClickDetector.MouseClick:Connect(function()
                    game:GetService("RunService"):UnbindFromRenderStep("CameraLookAtMouse")
                    if CameraClick2 and _G.PData.BaseFakeSettings.OpenShopPlayer then
                        TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam3.CFrame}):Play()
                        CameraClick2 = false
                    elseif not CameraClick2 and _G.PData.BaseFakeSettings.OpenShopPlayer then
                        enable(CameraFolder.LeadeBoard.Cam1)
                        print('aaa')
                        TweenService:Create(Cam, TweenInfo.new(0.4, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CameraFolder.LeadeBoard.Cam1.CFrame}):Play()
                        CameraClick2 = true
                    end
                end)
                
            elseif input.KeyCode == Enum.KeyCode.E and _G.PData.BaseFakeSettings.OpenShopPlayer then
                _G.PData.BaseFakeSettings.OpenShopPlayer = false
                CameraClick = false
                CameraClick2 = false
                disable()
                Controls:Enable()
            end
        end
    end
end)
-- дописать 

return leaderboard