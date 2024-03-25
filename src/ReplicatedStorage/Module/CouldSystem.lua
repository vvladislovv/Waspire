local CouldSystems = {}

--Cloud generator 2020

local OPAQUE = 0.35 --Cloud transparency
local SPEED = 10 --Studs clouds move per second
local DISTANCE = 25 --Distance between each point
local NUMBER = 300 --How many clouds to be generated ahead and to the sides of the starting part
local RANDOM = 500 --Max studs a cloud can be off a point by

local CoildClone = game.ReplicatedStorage.Could


local TS = game:GetService("TweenService")
local activity = workspace:WaitForChild("Activity")
local storage = activity.Clouds:WaitForChild("Storage")
local points = activity.Clouds:WaitForChild("Points")
local start = activity.Clouds:WaitForChild("Start")


local function generatePoints()
	local pointsList = {}
	local lastPoint = start
	local side = 1
	for pointNum = 1, NUMBER do
		local newPoint = Instance.new("Part")
		newPoint.Name = pointNum
		newPoint.Transparency = 1
		newPoint.Anchored = true
		newPoint.CanCollide = false
		newPoint.CFrame = lastPoint.CFrame * CFrame.new(DISTANCE * side * pointNum, 0, 0)
		newPoint.Parent = points
		lastPoint = newPoint
		side = side * -1 --Alternate left and right
		pointsList[tostring(pointNum)] = newPoint
		task.wait()
	end
	pointsList["0"] = start
	return pointsList
end

local function createCloud(point, headStart)
	local willACloudAppear = math.random(1, 5) --20% chance of a cloud appearing
	local appearInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
	local moveInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
	if willACloudAppear == 1 then
		local pickCloud = CoildClone[math.random(1,8)] --One in four chance of a smaller cloud
		local createCloud = pickCloud:Clone()
		createCloud.Name = "1"
		createCloud.Parent = storage
		createCloud.Transparency = 1
		if headStart == nil then
			headStart = 0
		end
		createCloud.CFrame = point.CFrame * CFrame.new(math.random(-RANDOM, RANDOM), math.random(-10, 10), math.random(-RANDOM, RANDOM)) * CFrame.new(0, 0, -headStart * 750)
		local cloudAppear = TS:Create(createCloud, appearInfo, {Transparency = OPAQUE})
		cloudAppear:Play()
		local moveNum = 0
		task.spawn(function()
			repeat
				local cloudMove = TS:Create(createCloud, moveInfo, {CFrame = createCloud.CFrame * CFrame.new(0, 0, -SPEED * 10)})
				cloudMove:Play()
				task.wait(10)
				moveNum = moveNum + 1
			until moveNum >= (DISTANCE - headStart)
			local cloudGone = TS:Create(createCloud, appearInfo, {Transparency = 1})
			cloudGone:Play()
			task.wait(1)
			createCloud:Destroy()
		end)
	end
end
local createPoints = generatePoints()
local timeColors = {["0"] = Color3.fromRGB(57, 58, 79)}

task.spawn(function()
	for start = 1, 11 do
		task.spawn(function()
			for i = 0, NUMBER do
				createCloud(createPoints[tostring(i)], start)
				task.wait()
			end
		end)
	end
end)

while task.wait(10) do
	task.spawn(function()
		for i = 0, NUMBER do
			createCloud(createPoints[tostring(i)])
			task.wait()
		end
	end)
end


return CouldSystems