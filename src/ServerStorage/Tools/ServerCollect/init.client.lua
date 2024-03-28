task.wait()
local Player = game.Players.LocalPlayer
local Characte = Player.Character or Player.CharacterAdded:Wait()
local HRP = Characte:WaitForChild("HumanoidRootPart")
local Him = Characte:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local Tools = require(ReplicatedStorage.Module.ItemsGame).Equipment.Tool
local CollectFlowerModule = require(ReplicatedStorage.Module.CollectFlower)
_G.PData = ReplicatedStorage.Remote.GetDataSave:InvokeServer()

local ToolInfo = Tools[_G.PData.Equipment.Tool]
local ModuleTool = Tools[_G.PData.Equipment.Tool]
if not ToolInfo then
	warn("Tool isn't in moduleScript. Please joiner ServerStrorage")
	return
end

local Collect = false
local Debonuce = false
local TableAnim = require(ReplicatedStorage.Module.ItemsGame).Equipment.Tool.Scissors.AnimTools

UIS.InputBegan:Connect(function(v1,v2)
	if not v2 and v1.UserInputType == Enum.UserInputType.MouseButton1 then
		Collect = true
	end
end)

UIS.InputEnded:Connect(function(v1,v2)
	if not v2 and v1.UserInputType == Enum.UserInputType.MouseButton1 then
		Collect = false
	end
end)


CAS:BindAction("Scoop", function(_, State)
	if State == Enum.UserInputState.Begin then
		Collect = true
	else 
		Collect = false
	end
end, true, Enum.KeyCode.ButtonB)
CAS:SetPosition("Scoop", UDim2.new(1, -70, 0, 10))
CAS:SetTitle("Scoop", "Scoop")

local Coouldown = {}

function CollectFlowerClient(AnimTrack, HRP)
    if _G.PData.BaseSettings.Pollen <= _G.PData.BaseSettings.Capacity and not Coouldown[Player.Name] then
        Coouldown[Player.Name] = true
        task.wait(AnimTrack.Length-0.8)

        CollectFlowerModule:CollectFlower(Player, {
            HRP = HRP,
            Offset = Vector3.new(0,0,0),
            Stamp = ModuleTool.BlockFieldCoper,
			StatsMOD = ModuleTool,
        })
        task.wait(ModuleTool.SpeedCoper - 0.2)
		Coouldown[Player.Name] = false
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if Collect and not Debonuce then
        Debonuce = true
		
		local Anim = Instance.new("Animation")
		Anim.AnimationId = TableAnim
		
		local AnimTrack = Him:LoadAnimation(Anim)
		local Cooldown = ToolInfo.SpeedCoper --/ (_G.PData.Boost.PlayerBoost["Collectors Speed"] / 100)
		AnimTrack.Priority = Enum.AnimationPriority.Action
		AnimTrack:Play()
		
		CollectFlowerClient(AnimTrack,HRP)
		task.wait(Cooldown)
		Debonuce = false
		
		task.spawn(function()
			--task.wait(AnimTrack.Lenght)
			Anim:Destroy()
		end)
    end
end)
