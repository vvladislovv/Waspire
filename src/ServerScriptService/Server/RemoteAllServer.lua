-- все ремуты которые нужны
local RemoteAllServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Data = require(script.Parent.Data)
local Remote = ReplicatedStorage:WaitForChild('Remote')

function BottalCoinData(Player, MathNumber, NofficalBottle)
    local PData = Data:Get(Player)
    if NofficalBottle then
        PData.BaseSettings.Coin += MathNumber
        PData.TimerTable["BottalCoin"] = {Time = 14400 + os.time()}
        --PData:Update('TimerTable', PData.TimerTable)
    else
        print(PData)
    end
end

function TutorialCheck(Player, Perment)
    local PData = Data:Get(Player)
    if Perment then
        PData.GameSettings.SnailTutorial = true
        --PData:Update('GameSettings', PData.GameSettings)
    end
end

function JumpingEffect(plr)
    local jumpEffect = game.ReplicatedStorage.Assert.JumpEffect:Clone()
	jumpEffect.Transparency = 1
	jumpEffect.Parent = workspace
	game.Debris:AddItem(jumpEffect,0.5)
	local weld = Instance.new("Weld",jumpEffect)
	weld.Part0 = plr.Character.HumanoidRootPart
	weld.Part1 = jumpEffect
	weld.C0 = CFrame.new(0,-3,0) * CFrame.fromEulerAnglesXYZ(0,0,1.5)
	jumpEffect.ParticleEmitter:Emit(1)
end

Remote.JumpingEffect.OnServerEvent:Connect(JumpingEffect)
Remote.BottalCoinEvent.OnServerEvent:Connect(BottalCoinData)
Remote.TutorialServer.OnServerEvent:Connect(TutorialCheck)
return RemoteAllServer





