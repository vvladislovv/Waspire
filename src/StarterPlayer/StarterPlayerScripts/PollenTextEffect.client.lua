
local Rs = game:GetService("ReplicatedStorage")
local VisEv = Rs.Remote.VisualNumber
local TextPollen = Rs.Assert.Visual
local Player = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local Utils = require(Rs.Libary.Utils)

local TableCollers = { 
	Coin = Color3.fromRGB(255, 195, 75),
	Crit = Color3.fromRGB(255, 172, 209),
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
	print(VP)
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

VisEv.OnClientEvent:Connect(function(Tab) -- може ркщк сделать через хуманоида и голову
	local VP = TextPollen:Clone()
	local Charater = game.Workspace:FindFirstChild(Player.Name)
	local function GetSize(Amt)
		local SizeValue = 2.5

		if Amt <= 10 then
			SizeValue = 2.5

		elseif Amt <= 1000 then
			SizeValue = 3.5
		elseif Amt <= 10000 then
			SizeValue = 4
		elseif Amt <= 100000 then
			SizeValue = 4.5
			--Rotation = math.random(15,25)
		end

		if Amt >= 101 then
			Crit(VP.BillboardGui.TextPlayer)
		elseif Amt >= 500 then
			Crit(VP.BillboardGui.TextPlayer)
		elseif Amt >= 1000 then
			Crit(VP.BillboardGui.TextPlayer)
		elseif Amt >= 3500 then
			Crit(VP.BillboardGui.TextPlayer)
		elseif Amt >= 10000 then
			Crit(VP.BillboardGui.TextPlayer)
			--Crit(VP.BillboardGui.TextPlayer)
			--Rotation = math.random(15,25)
		end

		return UDim2.fromScale(SizeValue, SizeValue / 2)
	end

	VP.Parent = game.Workspace.FolderTextPollen
	VP.BillboardGui.TextPlayer.Size = UDim2.new(0,0,0,0)

	TS:Create(VP.BillboardGui.TextPlayer, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,1,0)}):Play()
	VP.BillboardGui.Size = GetSize(Tab.Amt)
	VP.Name = Tab.Amt
	print(Tab)
	if Tab.Color == "Coin" and Tab.Color ~= "Damage" then
		if Tab.Pos then
			if typeof(Tab.Pos) == "Vector3" then
				print(Tab)
				VP.Position = Tab.Pos
			else
				print(Tab)
				VP.Position = Tab.Pos.Position
			end
		else
			print(VP.Position)
			VP.Position = Charater.PrimaryPart.Position
		end
		VP.Position += Vector3.new(0,0,0)
		VP.BillboardGui.TextPlayer.Text = "+"..Utils:CommaNumber(Tab.Amt)
		--VP.BillboardGui.TextPlayer.Rotation = math.random(-5,5)
		VP.BillboardGui.TextPlayer.TextColor3 = TableCollers[Tab.Color]
		GetLocation(VP)




		-- Если монеты или удары пока, что не нужны 
	end

	task.wait(0.4)
	TS:Create(VP.BillboardGui.TextPlayer, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
	task.wait(0.4)
	VP:Destroy()
end)
