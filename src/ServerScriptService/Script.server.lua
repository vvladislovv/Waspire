game.ReplicatedStorage.Remote.JumpingEffect.OnServerEvent:Connect(function(plr)
	local jumpEffect = game.ReplicatedStorage.Assert.JumpEffect:Clone()
	jumpEffect.Transparency = 1
	jumpEffect.Parent = workspace
	game.Debris:AddItem(jumpEffect,0.5)
	local weld = Instance.new("Weld",jumpEffect)
	weld.Part0 = plr.Character.HumanoidRootPart
	weld.Part1 = jumpEffect
	weld.C0 = CFrame.new(0,-3,0) * CFrame.fromEulerAnglesXYZ(0,0,1.5)
	jumpEffect.ParticleEmitter:Emit(1)
end)
