local PlayerSettings = {} -- Дописать 
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local PlayersGuiSettings = PlayerGui:WaitForChild("PlayerSettings")
local UICrowItems = PlayersGuiSettings.UICrowItems

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Tab then
        UICrowItems.Visible = true
    end
end)


UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Tab then
        UICrowItems.Visible = false
    end
end)
return PlayerSettings