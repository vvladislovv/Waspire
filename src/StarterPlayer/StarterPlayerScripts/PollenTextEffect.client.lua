
local Rs = game:GetService("ReplicatedStorage")
local VisEv = Rs.Remote.VisualNumber
local TextPollen = Rs.Assert.Visual
local Player = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local Utils = require(Rs.Libary.Utils)

local TableCollers = { 
	Coin = Color3.fromRGB(255, 195, 75),
	--Crit = Color3.fromRGB(255, 172, 209),
	Damage = Color3.fromRGB(255, 43, 47),

	White = Color3.fromRGB(255, 255, 255),
	Pupler = Color3.fromRGB(240, 75, 255),
	Blue = Color3.fromRGB(43, 117, 255),
}

local function Crit(Text)
	task.spawn(function()
		local RotationAngle = 25
		local BasicColor = Text.TextColor3
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()

		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()

		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()

		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()

		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()

		task.wait(0.25)
	end)
end

local HoneyPos = 0
local DanagePos = 0

function GetLocation(VP)
	for Count = 1,2 do
		for i,v in pairs(workspace.FolderTextPollen:GetChildren()) do
			for d, l in pairs(workspace.FolderTextPollen:GetChildren()) do
				if l ~= v then
					if (v.Position - l.Position).Magnitude <= 0.5 then --  Следующая позиция после первой текста 
						if  tonumber(l.Name) > tonumber(v.Name) then
							l.Position = v.Position + Vector3.new(0,v.BillboardGui.Size.Height.Scale,0)
						else
							l.Position = v.Position + Vector3.new(0,v.BillboardGui.Size.Height.Scale,0)
						end
					end
				end
			end
		end
	end
end

local function GetSize(Amount, Crit)
	local SizeValue = 0
	if Amount <= 100 then
		SizeValue = 2
	elseif Amount > 100 and Amount <= 1000 then
		SizeValue = 3
	elseif Amount > 1000 and Amount <= 5000 then
		SizeValue = 4
	elseif Amount > 5000 and Amount <= 10000 then
		SizeValue = 5
	elseif Amount > 10000 and Amount <= 25000 then
		SizeValue = 6
	elseif Amount > 25000 and Amount <= 50000 then
		SizeValue = 7
	elseif Amount > 50000 and Amount <= 100000 then
		SizeValue = 9
	elseif Amount > 100000 and Amount <= 1000000 then
		SizeValue = 12
	elseif Amount > 1000000 and Amount <= 5000000 then
		SizeValue = 15
	elseif Amount > 5000000 then
		SizeValue = 25
	end
	if Crit and Crit == true and _G.PData then
		SizeValue *= (_G.PData.AllStats["Critical Power"])
	end
	return UDim2.fromScale(SizeValue, SizeValue / 2)
end

local function ray(VP)
	local ray = RaycastParams.new()
	ray.FilterDescendantsInstances = {game.Workspace.FieldsGame}
	ray.FilterType = Enum.RaycastFilterType.Include
	local raycast = workspace:Raycast(VP.Position, Vector3.new(0,-100,0), ray)
	if raycast and raycast.Instance then
		local Hit = raycast.Instance
		if Hit.Name == "Flower" then
			VP.Position = Vector3.new(Hit.Position.X, VP.Position.Y, Hit.Position.Z)
		end
	end
end

VisEv.OnClientEvent:Connect(function(Tab) 
	local VP = TextPollen:Clone()
	local Character = game.Workspace:FindFirstChild(Player.Name)
	VP.Parent =  workspace.FolderTextPollen
	VP.BillboardGui.TextPlayer.Size = UDim2.new(0,0,0,0)
	TS:Create(VP.BillboardGui.TextPlayer, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,1,0)}):Play()
	VP.BillboardGui.Size = GetSize(Tab.Amt, Tab.Crit)
	VP.Name = Tab.Amt
	if Tab.Color ~= "Coin" and Tab.Color ~= "Damage" then
		if Tab.Pos then
			if typeof(Tab.Pos) == "Vector3" then
				VP.Position = Tab.Pos
			else
				VP.Position = Tab.Pos.Position
			end
		else
			VP.Position = Character.PrimaryPart.Position
		end
		VP.Position += Vector3.new(0,2,0)
		ray(VP)
		VP.BillboardGui.TextPlayer.Text = "+"..Utils:CommaNumber(Tab.Amt)
		VP.BillboardGui.TextPlayer.TextColor3 = TableCollers[Tab.Color]
		GetLocation(VP)

	elseif Tab.Color == "Coin" then
		VP.Parent = workspace.FolderTextPollen
		VP.Position = Character.PrimaryPart.Position + Vector3.new(0,5+HoneyPos,0)
		VP.BillboardGui.TextPlayer.Text = "+"..Utils:CommaNumber(Tab.Amount)
		VP.BillboardGui.TextPlayer.TextColor3 = TableCollers.Coin
		HoneyPos += VP.BillboardGui.Size.Height.Scale
		if HoneyPos > 3 then
			HoneyPos = 0
		end
		-- Если монеты или удары пока, что не нужны 
	end

	task.wait(0.5)
	TS:Create(VP.BillboardGui.TextPlayer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
	task.wait(0.25)
	VP:Destroy()
end)
