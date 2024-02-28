--Put the script inside StarterGui and you're set. Enjoy.
--Also, this isn't the best it could be. It could be cleaner code. Deal with it. Works fine. -asimo3089

local amount = 1 --This actually does nothing now but I'l leave it in anyway.

--asimo3089
local person = script.Parent.Parent
local cam = game.Workspace.CurrentCamera

repeat wait() until game.Workspace:findFirstChild(person.Name)~=nil
repeat wait() until game.Workspace:findFirstChild(person.Name):findFirstChild("Head")~=nil
local theperson = game.Workspace:findFirstChild(person.Name)
--script.Parent.Parent.CameraMode="LockFirstPerson" --first person
local head = game.Workspace:findFirstChild(person.Name):findFirstChild("Head")

--cam.FieldOfView = 80
local part = Instance.new("Part")
part.Anchored = true
part.CanCollide = false
part.Transparency = 0.5
part.BrickColor = BrickColor.new("Pastel light blue")
part.TopSurface = "Smooth"
part.BottomSurface = "Smooth"
part.formFactor = "Custom"
part.Size = Vector3.new(.2,1.2,.2)
local mesh = Instance.new("BlockMesh")
mesh.Scale = Vector3.new(.4,2,.4)
mesh.Parent = part
wait()

while true do
for i = 1, amount do
	wait(0.001)
	local drop = part:Clone()
------------------------------------------------------------------
	function onHit(hit)
drop:Remove()
end

drop.Touched:connect(onHit)
------------------------------------------------------------------
	drop.Parent = cam
	--drop.CFrame = head.CFrame *CFrame.new(math.random(-25,25),math.random(50,75),math.random(-25,25))
	drop.CFrame = cam.CoordinateFrame *CFrame.new(math.random(-25,25),math.random(40,55),math.random(-25,25))
	drop.Anchored = false
	--print(drop.Position)
end

		--wait(.2)
end
