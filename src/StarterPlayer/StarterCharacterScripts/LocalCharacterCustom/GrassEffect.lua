local Grasser = {}
local char = script.Parent.Parent

local plr = game:GetService("Players").LocalPlayer

local rnd = Random.new()

local foliageTouching = {}

local shakeIterations = 1
local shakeSpeed = 0.1
local shakeScale = 0.5
char.Humanoid.Touched:Connect(function(hit:Instance, bodyPart:Instance)

	if hit:FindFirstAncestor("InteractiveFoliage") and not table.find(foliageTouching, hit) then
		table.insert(foliageTouching, hit)

		--hit.Name = rnd:NextNumber()

		if not hit:FindFirstChild("OriginalCFrame") then
			local originalCF = Instance.new("CFrameValue")
			originalCF.Name = "OriginalCFrame"
			originalCF.Value = hit.CFrame
			originalCF.Parent = hit
		end

		bodyPart.TouchEnded:Wait()
		table.remove(foliageTouching, table.find(foliageTouching, hit))

		--Effect.Enabled = false





	--[[
			hit.Touched:Connect(function(Hit)
				local Char = Hit:FindFirstAncestorOfClass("Model")
				if plr.Character == nil then return end
				if char ~= plr.Character then return end
				if char:FindFirstChild("Humanoid") then
				Effect.Enabled = true
				task.wait(2)
				Effect.Enabled = false
				hit.TouchEnded:Connect(function()
						Effect.Enabled = false
						
					end)
					end
			end)

				]]

	end	

end)


game:GetService("RunService").Heartbeat:Connect(function()

	local v = char.HumanoidRootPart.AssemblyLinearVelocity.Magnitude

	if v > 0.1 then
		for _, foliage in pairs(foliageTouching) do
			shakeIterations += shakeSpeed

			local seed = tonumber(foliage.Name)

			local x = math.noise(tick() * shakeSpeed, shakeIterations, seed) * shakeScale
			local y = math.noise(tick() * shakeSpeed, shakeIterations + 1, seed) * shakeScale
			local z = math.noise(tick() * shakeSpeed, shakeIterations + 2, seed) * shakeScale

			local newCF = foliage.OriginalCFrame.Value
			newCF += Vector3.new(x, y, z)
			newCF *= CFrame.Angles(x, y, z)
			newCF = foliage.CFrame:Lerp(newCF, 0.1)

			foliage.CFrame = newCF
		end
	end
end)


return Grasser
