--depso
_G.bugspeed = 2 --  move speed
_G.bugoffset = CFrame.new(0,-1.1,0)


repeat 
	wait() 
until game:IsLoaded() == true

local UserInputService = game:GetService"UserInputService"
local TweenService = game:GetService"TweenService"
local LocalPlayer = game:GetService"Players".LocalPlayer
local Character = LocalPlayer.Character
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {
	Character
}
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local Camera = workspace.CurrentCamera
Camera.CameraSubject = Character.Head

local rayDirection = Vector3.new(0, -10, 0)
local t = 5
local KeyDown = false
local BUGCFRAME = Character.Head.CFrame

pcall(function()
	Character.Animate.Disabled = true
end)

for i,v in next, Character.Humanoid:GetPlayingAnimationTracks() do
	v:Stop()
end

game:GetService"RunService".RenderStepped:Connect(function()
	Character.Humanoid:ChangeState(11) -- continue to execute after death
	Character.Humanoid.JumpPower = 0
	Character.Humanoid.JumpHeight = 0
	Character.Humanoid.WalkSpeed = 0
	Character.Humanoid.HipHeight = 0
	Character.Humanoid.AutoRotate = false
	Character.Humanoid.PlatformStand = true 

	if KeyDown then
		local rayOrigin = (
			CFrame.lookAt(
				Character.Head.CFrame.Position+Vector3.new(
					0,
					4,
					0
				), 
				Camera.CFrame.Position
			) 
				* CFrame.new(
					0,
					0,
					_G.bugspeed
				)
		).Position

		local raycastResult = workspace:Raycast(
			rayOrigin, 
			rayDirection, 
			raycastParams
		)

		if raycastResult then
			BUGCFRAME=CFrame.new(
				raycastResult.Position
			)*_G.bugoffset
		end
	end
end)

if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then -- thx inf yild
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA"BasePart" and
			v.Name == "RightUpperLeg" or
			v.Name == "LeftUpperLeg" or
			v.Name == "RightUpperArm" or
			v.Name == "LeftUpperArm" then
			v:Destroy()
		end
	end
else
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA"BasePart" and
			v.Name == "Right Leg" or
			v.Name == "Left Leg" or
			v.Name == "Right Arm" or
			v.Name == "Left Arm" then
			v:Destroy()
		end
	end
end

game:GetService"RunService".RenderStepped:Connect(function()
	local camRotation = math.atan2(
		-Camera.CFrame.LookVector.X, 
		-Camera.CFrame.LookVector.Z
	) - (Camera.CFrame.LookVector.X/4.3)

	Character.HumanoidRootPart.CFrame = BUGCFRAME * CFrame.Angles(0,camRotation,0)
end)

UserInputService.InputBegan:Connect(function(input, gameprocessed)
	if gameprocessed then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		KeyDown = true
	end
end)
UserInputService.InputEnded:Connect(function(input, gameprocessed)
	if gameprocessed then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		KeyDown = false
	end
end)

for _, ins in pairs(Character:GetDescendants()) do
	if ins:IsA'BasePart' then
		game:GetService"RunService".RenderStepped:Connect(function()
			ins.CanCollide = false
			ins.Velocity = Vector3.new(
				0,
				2,
				0
			)
		end)
	end
end