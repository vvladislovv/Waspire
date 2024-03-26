local FlowerCollect = {}

local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remote = ReplicatedStorage:WaitForChild('Remote')
_G.PData = Remote.GetDataSave:InvokeServer()


function GetRotation(Character, Orientation)
    local HOrient = Character.PrimaryPart.Orientation

    if HOrient.Magnitude >= 50 and HOrient.Magnitude < 110 then
        Orientation = CFrame.Angles(0, math.rad(90), 0)


    elseif HOrient.Magnitude > -90 and HOrient.Magnitude < 90 then
        Orientation = CFrame.Angles(0, math.rad(-90), 0)


    elseif HOrient.Magnitude > 0 and HOrient.Magnitude < 50 then
        Orientation = CFrame.Angles(0, math.rad(-180), 0)


    elseif HOrient.Magnitude <= 110 and HOrient.Magnitude >= 180 then
        Orientation = CFrame.Angles(0, math.rad(0), 0)


    elseif HOrient.Magnitude > 110 and HOrient.Magnitude < 180 then
        Orientation = CFrame.Angles(0, math.rad(0), 0)
    end

    return Orientation
end

function FlowerCollect:CollectFlower(Player, Args)
    print(Args)
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
                                print('ff')
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
                        print('ff')
                        Remote.CollectField:FireServer(_G.PData, part, Args.HRP, nil, ModelStamp.PrimaryPart)
                    else
                        print('ff')
                        Remote.CollectField:FireServer(_G.PData, part, Args.HRP, nil, ModelStamp.PrimaryPart)
                    end
                    task.wait(0.1)
                    ModelStamp:Destroy()
                end
            end
        end)
    end
end

Remote.PollenEffect.OnClientEvent:Connect(function(plr, Pollen)
    Pollen.ParticleEmitter.Enabled = true
    task.wait(0.1)
    Pollen.ParticleEmitter.Enabled = false
end)

Remote.RegenPollen.OnClientEvent:Connect(function(Player,Pollen,FlowerPos)
    TweenService:Create(Pollen, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
end)

Remote.RegenPollen2.OnClientEvent:Connect(function(Player,Pollen,FlowerPosTime)
    TweenService:Create(Pollen, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = FlowerPosTime}):Play()
end)

Remote.FlowerDown.OnClientEvent:Connect(function(plr,Flower,DecAm)
    local FlowerPos = Flower.Position - Vector3.new(0,DecAm,0)
    TweenService:Create(Flower, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
        --TW:Create(Flower.TopTexture, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = (FieldGame.Flowers[Flower.FlowerID.Value].MaxP-Flower.Position.Y)/2.5}):Play()
end)
return FlowerCollect