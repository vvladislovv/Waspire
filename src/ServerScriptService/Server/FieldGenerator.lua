local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remote')
local FieldGenerator = {}

FieldGenerator.MaxFloderSize = 3
FieldGenerator.FlowerTexture = {
    ["1Blue"] = "rbxassetid://16804666619",
    ["2Blue"] = "rbxassetid://16804670208",
    ["3Blue"] = "rbxassetid://16804672980",
    
    ["1Pupler"] = "rbxassetid://16804647138",
    ["2Pupler"] = "rbxassetid://16804650053",
    ["3Pupler"] = "rbxassetid://16804651100",

    ["1White"] = "rbxassetid://16791144157",
    ["2White"] = "rbxassetid://16804620887",
    ["3White"] = "rbxassetid://16804623294",
}
FieldGenerator.Flowers = {}
FieldGenerator.FieldSettings = {
    ["Blue flowers"] = {
        Flowers = {
            MinB = 4,
            TwoB = 0,
            ThreeB = 0,

            MinP = 4,
            TwoP = 0,
            ThreeP = 0,

            MinW = 4,
            TwoW = 0,
            ThreeW = 0,
        },
    },
    ["Daisies"] = {
        Flowers = {
            MinB = 4,
            TwoB = 0,
            ThreeB = 0,

            MinP = 4,
            TwoP = 0,
            ThreeP = 0,

            MinW = 4,
            TwoW = 0,
            ThreeW = 0,
        },
    },
    ["Mushrooms"] = {
        Flowers = {
            MinB = 4,
            TwoB = 0,
            ThreeB = 0,

            MinP = 4,
            TwoP = 0,
            ThreeP = 0,

            MinW = 4,
            TwoW = 0,
            ThreeW = 0,
        },
    },
    ["Cave1"] = {
        Flowers = {
            MinB = 4,
            TwoB = 0,
            ThreeB = 0,

            MinP = 4,
            TwoP = 0,
            ThreeP = 0,

            MinW = 4,
            TwoW = 0,
            ThreeW = 0,
        },
    },
    ["Cave2"] = {
        Flowers = {
            MinB = 4,
            TwoB = 0,
            ThreeB = 0,

            MinP = 4,
            TwoP = 0,
            ThreeP = 0,

            MinW = 4,
            TwoW = 0,
            ThreeW = 0,
        },
    },
}


function TextInType(FN)
    local Type = {}
     -- Value Size Flower
        if string.find(FN, "Min") then
            Type["Value"] = "1"
        elseif string.find(FN, "Two") then
            Type["Value"] = "2"
        elseif string.find(FN, "Three") then
            Type["Value"] = "3"
        end

        -- Color Flower
        if string.find(FN, "P") then
            Type["Color"] = "Pupler"
        elseif string.find(FN, "B") then
            Type["Color"] = "Blue"
        elseif string.find(FN, "W") then
            Type["Color"] = "White"
        end

        Type["Texture"] = FieldGenerator.FlowerTexture[FN]
        
    return Type
end

function RandomNumberFlower(FieldName)
    local main = {}
    local Number = 0

    for i, v in pairs(FieldGenerator.FieldSettings[FieldName].Flowers) do
        main[#main+1] = {v + Number, i}
		Number = Number + v
    end

    local RandomeNumber = math.random(0, Number)
    for _, v in pairs(main) do
        if RandomeNumber <= v[1] then
            return v[2]
        end
    end
    return nil
end

function FieldGenerator:CreateFlower(Flower)
    local FlowerType = TextInType(RandomNumberFlower(Flower.Parent.Name))
    local FlowerID = Flower:FindFirstChild("FlowerID")
    local FlowerColor = FlowerType.Color
    local ID = #FieldGenerator.Flowers + 1
    FlowerID.Value = ID
    FieldGenerator.Flowers[ID] = {
        Stat = FlowerType,
        Color = FlowerColor,
        RegenFlower = 0.65,
        MaxP = Flower.Position.Y,
        MinP = Flower.Position.Y - 2.5,
    }
    Flower.TopTexture.Texture = FieldGenerator.FlowerTexture[FieldGenerator.Flowers[ID].Stat.Value..FieldGenerator.Flowers[ID].Color] -- Size; Color
end

function FieldGenerator:FlowerCreatINField(Field, Position)
    local FlowerClose = ReplicatedStorage.Assert.Flower:Clone()
    FlowerClose.Parent = Field
    FlowerClose.CFrame = Position
    
    local MathPOS = math.random(1,4)
    if MathPOS == 1 then FlowerClose.Orientation = Vector3.new(0,90,0) 
    elseif MathPOS == 2 then FlowerClose.Orientation = Vector3.new(0,180,0) 
    elseif MathPOS == 3 then FlowerClose.Orientation = Vector3.new(0,-90,0) 
    elseif MathPOS == 4 then FlowerClose.Orientation = Vector3.new(0,-180,0) end
    FieldGenerator:CreateFlower(FlowerClose)
end

function FieldGenerator:GenerateField(FlowerZoneP)
    local FieldRead = Instance.new("Model", workspace.FieldsGame)
        FieldRead.Name = FlowerZoneP.Name
        FlowerZoneP.Transparency = 1
        -- left(a+b) одна сторона
        -- right(a+b) вторая сторона
        local left = FlowerZoneP.Position + Vector3.new((FlowerZoneP.Size.X / 2) -2, 0, (FlowerZoneP.Size.Z / 2) -2)
        local right = FlowerZoneP.Position - Vector3.new((FlowerZoneP.Size.X / 2) -2, 0, (FlowerZoneP.Size.Z / 2) -2)

        -- Размеры
        local v1 = left.X
        local v2 = left.Z

        local v3 = right.X
        local v4 = right.Z

        for CFright  = math.min(v1,v3), math.max(v1,v3), 3 do
            for CFleft  = math.min(v2,v4), math.max(v2,v4), 3 do
                FieldGenerator:FlowerCreatINField(FieldRead, CFrame.new(CFright, left.Y, CFleft))
            end
        end
end

function FieldGenerator:GetField(Field)
	if game:GetService("RunService"):IsServer() then
		return FieldGenerator
	else
		return Remote.GetField:InvokeServer()
	end
end

game.ReplicatedStorage.Remote.GetField.OnServerInvoke = function(client)
    local PData = FieldGenerator:GetField(client)
    return PData
end


for _, Fields in pairs(workspace.FieldFolderStudio:GetChildren()) do
    FieldGenerator:GenerateField(Fields)
end
return FieldGenerator