local TokenClient = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remote")
local ts = game:GetService("TweenService")

--[[поднимается]]local TweenForCollect = TweenInfo.new(0.75, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)
--[[сужается]]local TweenForCollect2 = TweenInfo.new(0.75, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)

function Animation(part)
	task.spawn(function()

			local Size3 = part.Size
			local u1 = CFrame.fromEulerAnglesXYZ(0, 0, math.rad(90))
			local u2 = CFrame.fromEulerAnglesXYZ(0, 0, math.rad(-90))
			local u10 = Size3 * Vector3.new(1.5, 1.5, 1.5)

			ts:Create(part, TweenForCollect, {CFrame = (part.CFrame + Vector3.new(0, 2, 0)) * u1}):Play()
			ts:Create(part, TweenForCollect, {Size = Vector3.new(0.5, 4, 4)}):Play()

            task.wait(0.7)
			ts:Create(part, TweenForCollect2, {Size = Vector3.new(0,0,0)}):Play()

			task.wait(0.75)
			part:Destroy()
	end)
end

Remote.Token.OnClientEvent:Connect(function(Token)
	local Deb = false
	if Token then

	task.spawn(function()
		local T1 = ts:Create(Token, TweenInfo.new(4), {Transparency = 1})
		local T2 = ts:Create(Token:FindFirstChild("BackDecal"), TweenInfo.new(4), {Transparency = 1})
		local T3 = ts:Create(Token:FindFirstChild("FrontDecal"), TweenInfo.new(4), {Transparency = 1})

		ts:Create(Token, TweenInfo.new(0.65, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out,0.3), {Size = Vector3.new(0.5, 3, 3)}):Play()
		ts:Create(Token, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {CFrame = Token.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)}):Play()
		
        task.spawn(function()
			task.wait(15)

			if Token then
                T1:Play()
                T2:Play()
                T3:Play()
			end

			task.wait(4)

			if Token then
			    Token:Destroy()
			end
		end)

		Token.Touched:Connect(function(Hit)
			if Hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(Hit.Parent.Name) and Deb == false then
				Deb = true
				Token.CanTouch = false

				if Token:FindFirstChild("TokenCollect") then
					Token.TokenCollect:Play()
				else
					Token.Sound:Play()
				end

                T1:Pause()
                T2:Pause()
                T3:Pause()

				Token.Transparency = 0
				Token:FindFirstChild("BackDecal").Transparency = 0
				Token:FindFirstChild("FrontDecal").Transparency = 0

				Animation(Token)
			end
		end)
		end)
	end
end)
return TokenClient