--[[
local PS = game:GetService('Players')
local CLS = game:GetService('CollectionService')
local RPS = game:GetService('ReplicatedStorage')
local TWS = game:GetService('TweenService')
local RS = game:GetService('RunService')

local hitboxFolder : Folder = Instance.new('Folder') do
	hitboxFolder.Name = 'HitboxFolder'
	hitboxFolder.Parent = workspace
end

local player : Player = PS.LocalPlayer
local camera : Camera = workspace.CurrentCamera
local hitbox : BasePart = RPS.Hitbox

local grassData : {[BasePart] : {Top : Vector3, Pivot : Vector3, IsEligible : boolean, ActivationUpdated : boolean}} = {}
local hitboxes : {[BasePart] : {IsEligible : boolean, ActivationUpdated : boolean}} = {}
local activeParts : {BasePart} = {}

local playerConnections : {[string] : {CharacterAdded : RBXScriptConnection, CharacterRemoving : RBXScriptConnection}} = {}
local physicsConnections : {[BasePart] : {Touched : RBXScriptConnection?, TouchEnded : RBXScriptConnection}} = {}  
local hitboxConnections : {[BasePart] : RBXScriptConnection} = {}

local rotationCFrame : CFrame = CFrame.Angles(0, math.rad(-90), math.rad(90))
local upAxis : Vector3 = Vector3.FromNormalId(Enum.NormalId.Back)
local tweenInfo : TweenInfo = TweenInfo.new(1.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0)
local root3 : number = math.sqrt(3)

local timeCount : number = 0
local updateTimeCount : number = 0
local timeInterval : number = 0.1
local updateInterval : number = timeInterval * 2
local updateCount : number = 0
local activationRadius : number = 200

local eligibilityChanged : boolean = false
local hitboxEligibilityChanged : boolean = false
local lastCFrame : CFrame = camera.CFrame

local function tween(name : string, mesh : MeshPart, newCFrame : CFrame)
	if mesh:FindFirstChild(name) and mesh[name]:IsA('Tween') then
		mesh[name]:Destroy()
	end

	local tween = TWS:Create(mesh, tweenInfo, {CFrame = newCFrame})
	tween.Name = name
	tween.Parent = mesh
	tween:Play()
	tween.Completed:Connect(function()
		tween:Destroy()
		tween = nil
	end)
end

local function activateHitbox(hitboxInstance : BasePart)
	physicsConnections[hitboxInstance] = {}

	physicsConnections[hitboxInstance].Touched = hitboxInstance.Touched:Connect(function(partTouched : BasePart)
		if not (grassData[partTouched]) or not (grassData[partTouched].IsEligible) then return end
		if (table.find(activeParts, partTouched)) then return end

		activeParts[#activeParts + 1] = partTouched

		local data = grassData[partTouched]

		local direction : Vector3 = ((hitboxInstance.Position - partTouched.Position) * -Vector3.new(1, 0, 1)).Unit * partTouched.Size.Y/root3
		local newLookAt : Vector3 = (data.Top + direction)
		local newPosition : Vector3 = data.Pivot + ((newLookAt - data.Pivot).Unit * partTouched.Size.Y/2)

		local finalCFrame = CFrame.lookAt(newPosition, newLookAt, upAxis) * rotationCFrame
		tween('pivot', partTouched.Parent, finalCFrame)
	end)

	physicsConnections[hitboxInstance].TouchEnded = hitboxInstance.TouchEnded:Connect(function(partTouched : BasePart)
		local index = table.find(activeParts, partTouched)
		if not (grassData[partTouched]) or not (index) then return end
		if not (grassData[partTouched].IsEligible) then return end

		table.remove(activeParts, index)
		tween('pivot', partTouched.Parent, partTouched.CFrame)
	end)

	hitboxInstance.BrickColor = BrickColor.new('Magenta')
end

local function deactivateHitbox(hitboxInstance : BasePart)
	if (physicsConnections[hitboxInstance]) then
		physicsConnections[hitboxInstance].Touched:Disconnect()
		physicsConnections[hitboxInstance].TouchEnded:Disconnect()
		physicsConnections[hitboxInstance] = nil
	end

	--hitboxInstance.BrickColor = BrickColor.new('Really red')
end

local function activateGrass(grassInstance : MeshPart)
	grassInstance.Hitbox.CanTouch = true
	--grassInstance.BrickColor = BrickColor.new('Camo')
end

local function deactivateGrass(grassInstance : MeshPart)
	grassInstance.Hitbox.CanTouch = false

	if (grassInstance:FindFirstChild('pivot')) then
		grassInstance.pivot:Cancel()
		grassInstance.CFrame = grassInstance.Hitbox.CFrame
	end

	local index = table.find(activeParts, grassInstance.Hitbox)
	if (index) then
		table.remove(activeParts, index)
		grassInstance.CFrame = grassInstance.Hitbox.CFrame
	end

	--grassInstance.BrickColor = BrickColor.new('New Yeller')
end

local function setupGrass(grassInstance : BasePart)
	local hasHitbox = grassInstance:FindFirstChild('Hitbox')
	local grassHitbox = hasHitbox or Instance.new('Part')

	grassData[grassHitbox] = {
		Top = grassInstance.Position + Vector3.new(0, grassInstance.Size.Y/2, 0),
		Pivot = grassInstance.Position - Vector3.new(0, grassInstance.Size.Y/2, 0),
		IsEligible = true,
		ActivationUpdated = false,
	}

	if not (hasHitbox) then
		grassInstance.CFrame = CFrame.lookAt(grassInstance.Position, grassData[grassHitbox].Top, upAxis) * rotationCFrame
		grassHitbox.CFrame = grassInstance.CFrame
		grassHitbox.Size = grassInstance.Size
		grassHitbox.CanCollide = false
		grassHitbox.CanQuery = false
		grassHitbox.Anchored = true
		grassHitbox.Massless = true
		grassHitbox.CastShadow = false
		grassHitbox.Transparency = 1
		grassHitbox.Name = 'Hitbox'
		grassHitbox.Parent = grassInstance
	end
end

local function removeGrass(grassInstance : BasePart)
	deactivateGrass(grassInstance)

	if (grassData[grassInstance.Hitbox]) then
		grassData[grassInstance.Hitbox] = nil
	end

	grassInstance.Hitbox:Destroy()
end

local function setupHitbox(hitboxInstance : BasePart)
	if not (hitboxInstance:IsDescendantOf(workspace)) then return end
	hitboxes[hitboxInstance] = {IsEligible = true, ActivationUpdated = false}

	activateHitbox(hitboxInstance)
end

local function removeHitbox(hitboxInstance : BasePart)
	deactivateHitbox(hitboxInstance)

	if hitboxes[hitboxInstance] then
		hitboxes[hitboxInstance] = nil
	end

	if (hitboxConnections[hitboxInstance]) then
		hitboxConnections[hitboxInstance]:Disconnect()
		hitboxConnections[hitboxInstance] = nil
	end
end

local function cameraCFrameChanged(hitboxOnly : boolean)
	local controlVector : Vector3 = lastCFrame.LookVector
	local threshold : number = camera.FieldOfView + 2

	-- If error
	--task.desynchronize()

	if not (hitboxOnly) then
		for hitbox, data in grassData do

			local directionVector : Vector3 = (hitbox.Position - lastCFrame.Position)
			local angle : number = math.floor(math.deg(directionVector.Unit:Angle(controlVector)))

			-- If the distance is not within the radius, we check to see if its in the camera's viewport, and activate if its inside the viewport.
			if (angle <= threshold) then

				local directionVector2 : Vector3? = player.Character and player.Character.PrimaryPart and (hitbox.Position - player.Character.PrimaryPart.Position) 
				local xzDistance : number? = directionVector2 and (Vector3.new(directionVector2.X, 0, directionVector2.Z)).Magnitude

				-- If the distance is within the activationRadius, then the grass will be activated regardless of if the camera has it in its viewport or not.
				if (xzDistance) and (xzDistance <= activationRadius) then
					if not (data.IsEligible) then
						eligibilityChanged = true
						data.IsEligible = true
						data.ActivationUpdated = false
					end 
				else
					if (data.IsEligible) then
						eligibilityChanged = true
						data.IsEligible = false
						data.ActivationUpdated = false
					end
				end
			else
				if (data.IsEligible) then
					eligibilityChanged = true
					data.IsEligible = false
					data.ActivationUpdated = false
				end
			end
		end
	end

	for hitbox, data in hitboxes do
		local directionVector : Vector3 = (hitbox.Position - lastCFrame.Position)
		local angle : number = math.floor(math.deg(directionVector.Unit:Angle(controlVector)))

		if (angle <= threshold) then
			local directionVector2 : Vector3? = player.Character and player.Character.PrimaryPart and (hitbox.Position - player.Character.PrimaryPart.Position) 
			local xzDistance : number? = directionVector2 and (Vector3.new(directionVector2.X, 0, directionVector2.Z)).Magnitude

			-- If the distance is within the activationRadius, then the grass will be activated regardless of if the camera has it in its viewport or not.
			if (xzDistance) and (xzDistance <= activationRadius) then
				if not (data.IsEligible) then
					hitboxEligibilityChanged = true
					data.IsEligible = true
					data.ActivationUpdated = false
				end 
			else
				if (data.IsEligible) then
					hitboxEligibilityChanged = true
					data.IsEligible = false
					data.ActivationUpdated = false
				end
			end
		else
			if (data.IsEligible) then
				hitboxEligibilityChanged = true
				data.IsEligible = false
				data.ActivationUpdated = false
			end
		end
	end

	--If Error
	--task.synchronize()
end

local function characterAdded(character : Model)
	local primaryPart : BasePart = character:WaitForChild('HumanoidRootPart')
	local newHitbox : BasePart = hitbox:Clone()

	local attachment = Instance.new('Attachment')
	attachment.Parent = newHitbox

	local alignPosition : AlignPosition = Instance.new('AlignPosition') do
		alignPosition.RigidityEnabled = true
		alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		alignPosition.Attachment0 = attachment
		alignPosition.Enabled = true
		alignPosition.Parent = attachment

		hitboxConnections[newHitbox] = RS.Stepped:Connect(function()
			alignPosition.Position = primaryPart.Position
		end)
	end

	newHitbox.Position = primaryPart.Position
	newHitbox.Parent = hitboxFolder
	CLS:AddTag(newHitbox, 'Hitbox')
end

local function characterRemoving(character : Model)
	--character.Hitbox:Destroy() -- Player Hitbox
end

local function updateCamera(dt : number)
	timeCount += dt

	if (timeCount > updateInterval) then
		timeCount = 0

		if (camera.CFrame.Position - lastCFrame.Position).Magnitude > 1 or (camera.CFrame.Rotation ~= lastCFrame.Rotation) then
			updateCount = 0
			lastCFrame = camera.CFrame
			task.spawn(cameraCFrameChanged)
		else
			updateCount += 1
			if (updateCount > 4) then
				updateCount = 0
				task.spawn(cameraCFrameChanged, true)
			end
		end
	end
end

local function updateActivation(dt : number)
	updateTimeCount += dt

	if (updateTimeCount > (updateInterval)) then
		updateTimeCount = 0

		-- Update activation for grass
		if (eligibilityChanged) then
			eligibilityChanged = false

			for hitbox, data in grassData do
				if (data.IsEligible) then

					if not (data.ActivationUpdated) then
						data.ActivationUpdated = true
						activateGrass(hitbox.Parent)
					end

				else
					if not (data.ActivationUpdated) then
						data.ActivationUpdated = true
						deactivateGrass(hitbox.Parent)
					end
				end
			end
		end

		-- Update activation for hitboxes
		if (hitboxEligibilityChanged) then
			hitboxEligibilityChanged = false

			for hitbox, data in hitboxes do
				if (data.IsEligible) then
					if not (data.ActivationUpdated) then
						data.ActivationUpdated = true
						activateHitbox(hitbox)
					end
				else
					if not (data.ActivationUpdated) then
						data.ActivationUpdated = true
						deactivateHitbox(hitbox)
					end
				end
			end
		end
	end
end

PS.PlayerAdded:Connect(function(player : Player)
	playerConnections[player.Name] = {
		CharacterAdded = player.CharacterAdded:Connect(characterAdded),
		CharacterRemoving = player.CharacterRemoving:Connect(characterRemoving)
	}

	if (player.Character) then
		characterAdded(player.Character)
	end
end)

PS.PlayerRemoving:Connect(function(player : Player)
	playerConnections[player.Name].CharacterAdded:Disconnect()
	playerConnections[player.Name].CharacterRemoving:Disconnect()
	playerConnections[player.Name] = nil
end)

wait(1)

--print("Detecting Grass")

CLS:GetInstanceAddedSignal('Grass'):Connect(setupGrass)
CLS:GetInstanceRemovedSignal('Grass'):Connect(removeGrass)

CLS:GetInstanceAddedSignal('Hitbox'):Connect(setupHitbox)
CLS:GetInstanceRemovedSignal('Hitbox'):Connect(removeHitbox)

RS:BindToRenderStep('cameraUpdate', Enum.RenderPriority.Camera.Value, updateCamera)
RS:BindToRenderStep('activationUpdate', Enum.RenderPriority.Camera.Value + 2, updateActivation)

for i, grassInstance in (CLS:GetTagged('Grass')) do
	--print("Grass")
	setupGrass(grassInstance)
end

for i, hitboxInstance in (CLS:GetTagged('Hitbox')) do
	setupHitbox(hitboxInstance)
end

for i,player in (PS:GetPlayers()) do
	playerConnections[player.Name] = {
		CharacterAdded = player.CharacterAdded:Connect(characterAdded),
		CharacterRemoving = player.CharacterRemoving:Connect(characterRemoving)
	}

	if (player.Character) then
		characterAdded(player.Character)
	end
end]]