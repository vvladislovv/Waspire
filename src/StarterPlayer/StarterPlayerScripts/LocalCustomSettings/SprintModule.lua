local module = {}

local Player=game.Players.LocalPlayer -- Getting the Player [Only works in LocalScripts]
local UserInputService=game:GetService("UserInputService") -- Service to Detect Input 
local TweenService=game:GetService("TweenService") -- Service to Smoothly Transition Between Properties
--[[]]--

local IsSprinting=false -- Player is not Sprinting by Default
local Settings={
	["NormalSpeed"]=16; -- Default WalkSpeed of Player
	["SprintSpeed"]=25; -- Speed While Sprinting
	["NormalFov"]=70; -- Default Field of View of Player
	["SprintFov"]=85; -- Sprinting Field of View of Player
}
--[[]]--
local function StartSprinting()
	if not Player.Character then 
		-- Player does not have a character
		return
	end
	if not Player.Character:FindFirstChild("HumanoidRootPart") then
		-- Player is dead
		return
	end
	if IsSprinting==true then
		-- Player is already sprinting
		return
	end
	IsSprinting=true
	TweenService:Create(workspace['CurrentCamera'],TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{FieldOfView=Settings.SprintFov}):Play()
	TweenService:Create(Player.Character.Humanoid,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{WalkSpeed=Settings.SprintSpeed}):Play()	
end
--[[]]--
local function StopSprinting()
	if IsSprinting==false then
		-- Player is not sprinting
		return
	end
	IsSprinting=false
	TweenService:Create(workspace['CurrentCamera'],TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out,0,false,0),{FieldOfView=Settings.NormalFov}):Play()
	TweenService:Create(Player.Character.Humanoid,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{WalkSpeed=Settings.NormalSpeed}):Play()	
end

UserInputService.InputBegan:Connect(function(Input,GameProcessed)
	if GameProcessed then
		-- User is Typing in Chat
		return -- Prevent further code from running
	end
	if Input.KeyCode==Enum.KeyCode.LeftShift then -- Player Pressed LeftShift
		StartSprinting()
	end
end)

UserInputService.InputEnded:Connect(function(Input,GameProcessed)
	if GameProcessed then
		-- User is typing in chat
		return -- Prevent further code from running
	end
	if Input.KeyCode==Enum.KeyCode.LeftShift then -- Player Released LeftShift
		StopSprinting()
	end
end)

return module
