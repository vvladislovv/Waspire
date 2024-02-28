local MiniGrass = workspace.InteractiveFoliage
local Player = game:GetService('Players').LocalPlayer

local GrassEffect = {}


for _, index in next, MiniGrass:GetChildren()  do
	if index.Name == "Union" then
		index.Touched:Connect(function(hit)
			if hit.Parent == Player.Character then
				index.ParticleEmitter.Enabled = true
			end
		end)
		
		index.TouchEnded:Connect(function(hit)
			if hit.Parent == Player.Character then
				task.wait(0.5)
				--print('Touched not')
				index.ParticleEmitter.Enabled = false
			end
		end)
	end
end

for _, TreeAnim in next, MiniGrass:GetChildren() do
	local x = 0
	local z = 0
	local taller = -9999999
	local Pos = TreeAnim.Position
	local tall = TreeAnim.Size.Y / 2
	math.randomseed(tick())
	local rand = (math.random(0,20))/10
	task.spawn(function()
		while true do
			task.wait()
			local x = Pos.x + (math.sin(taller + (Pos.x/5)) * math.sin(taller/9))/5
			local z = Pos.z + (math.sin(taller + (Pos.z/6)) * math.sin(taller/12))/5
			TreeAnim.CFrame = CFrame.new(x, Pos.y, z) * CFrame.Angles((z-Pos.z)/tall, 0,(x-Pos.x)/-tall)
			task.wait()
			taller = taller + 0.15
		end
	end)
end

return GrassEffect