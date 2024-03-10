local RainHandlr = {}

task.spawn(function()
	while true do
		local player = game.Players.LocalPlayer
		local sound = script.RainSound
		wait(15)

		local TweenService = game:GetService("TweenService")

		local part = game.Workspace.Terrain.Clouds

		local goal = {}
		goal.Density = 5
		--change this to how dense you want the clouds to be
		goal.Cover = 5
		--change this to how much the clouds cover the sky
		sound:Play()
		local tweenInfo = TweenInfo.new(15)
		--change the 5 to how long you want the transition to happen

		local tween = TweenService:Create(part, tweenInfo, goal)

		tween:Play()
		player.PlayerGui.Rain.Disabled = false

		wait(15)
		local TweenService = game:GetService("TweenService")

		local part = game.Workspace.Terrain.Clouds

		local goal = {}
		goal.Density = 1
		--change this to how dense you want the clouds to be
		goal.Cover = 0.5
		--change this to how much the clouds cover the sky
		sound:Stop()
		local tweenInfo = TweenInfo.new(15)
		--change the 5 to how long you want the transition to happen

		local tween = TweenService:Create(part, tweenInfo, goal)

		tween:Play()
		player.PlayerGui.Rain.Disabled = true
	end
end)

return RainHandlr
