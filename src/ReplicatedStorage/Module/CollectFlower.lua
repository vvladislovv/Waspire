local FlowerCollect = {}
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local Zone = require(game.ReplicatedStorage:WaitForChild('Zone'))
_G.PData = Remote.GetDataSave:InvokeServer()
_G.Field = Remote.GetField:InvokeServer()

local TablePlayerFlower = {}
local Item = require(ReplicatedStorage.Module.ItemsGame)

function GetRotation(Character, Orientation)
    local HOrient = Character.PrimaryPart.Orientation
    if HOrient.Magnitude >= 50 and HOrient.Magnitude < 110 then
		Orientation = CFrame.Angles(0, math.rad(90), 0)
	end

	if HOrient.Magnitude > -90 and HOrient.Magnitude < 90 then
		Orientation = CFrame.Angles(0, math.rad(-90), 0)
	end

	if HOrient.Magnitude > 0 and HOrient.Magnitude < 50 then
		Orientation = CFrame.Angles(0, math.rad(0), 0)
	end

	if HOrient.Magnitude <= 110 and HOrient.Magnitude >= 180 then
		Orientation = CFrame.Angles(0, math.rad(-90), 0)
	end

	if HOrient.Magnitude > 110 and HOrient.Magnitude < 180 then
		Orientation = CFrame.Angles(0, math.rad(180), 0)
	end

    return Orientation
end

function FlowerCollect:CollectFlower(Player, Args)
    local Character = workspace:FindFirstChild(Player.Name)
    local ModelStamp = ReplicatedStorage.FolderStamps[Args.Stamp]:Clone()
    ModelStamp.Parent = workspace.StampsWorksSpawn

    local hit = Instance.new("Part")
    hit.Name = "Hit"
    hit.CanCollide = false
    hit.Size = Vector3.new(0.1,0.1,0.1)
    hit.Parent = Args.HRP
    hit.Orientation = Args.HRP.Orientation
    hit.Transparency = 1
    hit.Anchored = false
    hit.Massless = true
    hit.Position = Args.HRP.Position + Args.Offset

    hit.Touched:Connect(function(Part)
        if Part.Name == "Flower" then
            
            task.spawn(function()
                --local toolsSop = coroutine.create
                if ModelStamp:IsA("Model") then

                    for _, Object in pairs(ModelStamp:GetChildren()) do
                        Object.Anchored = false
                    end

                    ModelStamp:SetPrimaryPartCFrame(CFrame.new(Part.Position) * GetRotation(Character))
                    task.wait(0.2)
                    
                    for _, Object in pairs(ModelStamp:GetChildren()) do
                        Object.Anchored = true
                    end

                    task.wait(0.1)

                    pcall(function()
                        ModelStamp:SetPrimaryPartCFrame(CFrame.new(Args.HRP.Position))
                    end)
                else
                    ModelStamp.CFrame = CFrame.new(Part.Position) * GetRotation(Character)
                end
            end)
        end
    end)


    hit.Position = hit.Position + Vector3.new(0, -2.48, 0)
    task.wait()
    hit:Destroy()
    
    local WoldHit = Instance.new("WeldConstraint", hit)
    WoldHit.Part0 = Args.HRP
    WoldHit.Part1 = hit

    local Flowers = {}
        if ModelStamp:IsA("Model") then
            for i, v in pairs(ModelStamp:GetChildren()) do
                if v.Name ~= "Root" then
                    v.Touched:Connect(function(part)
                        if part.name == "Flower" then
                            if not table.find(Flowers, part) then
                                table.insert(Flowers, part)
                                Remote.CollectField:FireServer(_G.PData, part, Args.HRP, nil, ModelStamp.PrimaryPart)
                                task.wait(0.1)
                                ModelStamp:Destroy()
                            end
                        end
                    end)
                end
            end
        else

        ModelStamp.Touched:Connect(function(part)
            if part.Name == "Flower" then
                if not table.find(Flowers, part) then
                    table.insert(Flowers, part)
                    if Args.StatsMOD then
                        Remote.CollectField:FireServer(_G.PData, part, Args.HRP, nil, ModelStamp.PrimaryPart)
                    else
                        Remote.CollectField:FireServer(_G.PData, part, Args.HRP, nil, ModelStamp.PrimaryPart)
                    end
                    task.wait(0.1)
                    ModelStamp:Destroy()
                end
            end
        end)
    end
end

function FlowerCollect:RegenUp(Field : Instance)
    local InfoFieldGame = _G.Field[Field.Name]
        task.spawn(function()
            while Field do task.wait(5)
                for i, Pollen in pairs(Field:GetChildren()) do
                    if Pollen:IsA("BasePart") then
                    InfoFieldGame = _G.Field.Flowers[Pollen.FlowerID.Value]
                        if Pollen.Position.Y < InfoFieldGame.MaxP then
                            local ToMaxFlower = tonumber(InfoFieldGame.MaxP - Pollen.Position.Y)
                            local FlowerPos = Pollen.Position + Vector3.new(0, ToMaxFlower, 0)
                            local FlowerPosTime = Pollen.Position + Vector3.new(0,InfoFieldGame.RegenFlower,0)

                            if ToMaxFlower < InfoFieldGame.RegenFlower then
                                Pollen.ParticleEmitter.Enabled = false
                                TweenService:Create(Pollen, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
                            else
                                Pollen.ParticleEmitter.Enabled = false
                                TweenService:Create(Pollen, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPosTime}):Play()
                            end
                        end
                    end 
                end
            end
        end)
end

Remote.FlowerDown.OnClientEvent:Connect(function(Flower,DecAm)
    local FlowerPos = Flower.Position - Vector3.new(0,DecAm,0)
    TweenService:Create(Flower, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
    Flower.ParticleEmitter.Enabled = true
    task.wait(0.25)
    Flower.ParticleEmitter.Enabled = false
end)

for _, Field in pairs(workspace.FieldsGame:GetChildren()) do
    FlowerCollect:RegenUp(Field)
end


for _, v in next, workspace.FieldsGame:GetChildren() do
    local Zone = Zone.new(v)
    Zone.playerEntered:Connect(function(Player)
        _G.PData.BaseFakeSettings.FieldVars = v.Name
        _G.PData.BaseFakeSettings.FieldVarsOld = v.Name
    end)

    Zone.playerExited:Connect(function(Player)
        _G.PData.BaseFakeSettings.FieldVars = ""
    end)
end

return FlowerCollect