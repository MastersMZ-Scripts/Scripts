--[[
	           ,."""""""""""""".,
	        .d"                  "b.
	      .d                        b.
	    ."         .. depso ..        ".
	   P        z$*"        "*e.        9.
	  A       d"                "b       A
	 J       J    .e*""""""%c     A       L
	A       A    d"          $     L      A
	#       %   d      d**y  'L    %      #
	#       %   $     $ ,, Y  .$   %      #       _ _ 
	#       %   $     *  """   F   %      #      (@)@)
	#       V    4.    $.   .e"    Y      #        % %
	#        $    *.    """"     .Y      V         $ $
	#        'b     "b.      ..e*       Y         .eeee
	V         '$      ""eeee""        eP         A     %
	 Y         eb                ..d*"         _#    O %
	 I    _e%*""""*$ee......ee$*"eeeeeeeezee$**"       $
	  V ,"                                            B
	  J'                                        _,e=""
	.'#######################################DWB''

	Made by Depso - mastersmzscripts.com
	The SNAIL Script V2 (LIMBS VERSION)
	
	To update the config, run the script again.
]]

------------------------------

if not _G.Snail_Config  then
	return warn("[SNAIL SCRIPT] Please run the Snail script loader instead, thanks.")
end

local RunConnections = {}
local Config = _G.Snail_Config -- Temp

--// Fix config for old movement
if Config.UseCameraRotaton then
	Config.DistanceChangesSpeed = false
end

--// Only run the script to update the config
if _G.Snail_Ran then
	return 
end
_G.Snail_Ran = true

--// Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

--// Instances
local raycastParams
local Camera = workspace.CurrentCamera
local SnailPartsFolder = Instance.new("Folder", workspace)

-- Camera focus
local CameraPart = Instance.new("Part", SnailPartsFolder)
CameraPart.Anchored = true
CameraPart.Transparency = 0.5
CameraPart.Size = Vector3.new(1.5,1.5,1.5)
CameraPart.Color = Color3.fromRGB(255, 170, 0)
CameraPart.CanCollide = false

-- Teleport highlight
local HighlightPart = Instance.new("Part", SnailPartsFolder)
HighlightPart.Anchored = true
HighlightPart.Transparency = 1
HighlightPart.Size = Vector3.new(2,2,2)
HighlightPart.Color = Color3.fromRGB(255, 0, 0) 
HighlightPart.Shape = Enum.PartType.Ball
HighlightPart.CanQuery = false
HighlightPart.CanCollide = false
HighlightPart.Material = Enum.Material.ForceField

--// LocalPlayer
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local IsMobile = UserInputService.TouchEnabled or Config.UseCameraRotaton
local PlayerGui = LocalPlayer.PlayerGui

local Character: Model
local Head: Part
local Root: Part
local Humanoid: Humanoid

--// Functions

--// Sound service
local Sounds = {}
for Name, Info in next, Config.Audios do
	local Parent = LocalPlayer.PlayerGui
	local Sound = Instance.new("Sound", Parent)
	Sound.Volume = 0.5

	--// Change properties for sound
	for Key, Value in next, Info do
		if Key == "SoundId" then
			Value = `rbxassetid://{Value}`
		end
		Sound[Key] = Value
	end

	--// Overwrite
	Sounds[Name] = Sound
end

local function PlaySound(Sound: Sound)
	if not _G.Snail_Config.Sounds then return end
	Sound:Play()
end
local function StopSound(Sound: Sound)
	Sound:Stop()
end

function CharacterAdded(NewChar: Model)
	if not _G.Snail_Config.Enabled then return end

	--// Collect Humanoid Limbs
	Character = NewChar
	Head = Character:WaitForChild("Head")
	Humanoid = Character:WaitForChild("Humanoid")
	Root = Humanoid.RootPart

	--// Destroy all previous NoClip connections
	for _, Connection in next, RunConnections do
		Connection:Disconnect()
	end

	raycastParams = Get_raycastParams()
	delay(1, function()
		Camera.CameraSubject = CameraPart
	end)

	--// Call character functions
	RemoveLimbs()
	ApplyVelocity()
	ApplyNoClip()
	RemoveTouchControls()
	delay(2, StopAnimations)

	--// Modify Humanoid 
	Humanoid.WalkSpeed = 0
	Humanoid.HipHeight = 0
	Humanoid.AutoRotate = false
	Humanoid.PlatformStand = true 
end

function RemoveTouchControls()
	local GUI = PlayerGui:FindFirstChild("TouchGui")
	if not GUI then return end
	GUI:Remove()
end

function StopAnimations()
	local AnimateScript = Character:FindFirstChild("Animate")
	if AnimateScript then
		AnimateScript.Disabled = true
	end
	
	spawn(function()
		while wait(1) and AnimateScript do
			AnimateScript.Disabled = true
		end
	end)
	
	-- Suspend all active tracks
	for _, Track in next, Humanoid:GetPlayingAnimationTracks() do
		Track:Stop()
	end
end

function ApplyNoClip()
	local Connection = RunService.RenderStepped

	--// Loop through Character limbs
	for _, ins in next, Character:GetDescendants() do
		if not ins:IsA'BasePart' then continue  end

		table.insert(RunConnections, Connection:Connect(function()
			ins.CanCollide = false
		end))
	end
end

function ApplyVelocity()
	for _, limb in next, Character:GetChildren() do
		if not limb:IsA("BasePart") then continue  end

		--// Create static Velocity
		local LinearVelocity = Instance.new("LinearVelocity", limb)
		local Attachment0 = Instance.new("Attachment", limb)

		LinearVelocity.Attachment0 = Attachment0
		LinearVelocity.MaxForce = math.huge
		LinearVelocity.VectorVelocity = Vector3.zero
	end 
end

function RemoveLimbs()
	--// Teleport old parts away
	local OldLocation = Root.CFrame
	Root.CFrame = CFrame.new(0,10^5,0)

	--// Remove body limbs
	for _, limb in next, Character:GetChildren() do
		if not limb:IsA("BasePart") then continue  end

		if limb.Name:find("Leg") or limb.Name:find("Arm") then
			limb:Remove()
		end
	end
	wait()

	Root.CFrame = OldLocation
end

function Get_raycastParams()
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.IgnoreWater = true
	Params.FilterDescendantsInstances = {
		Character,
		CameraPart
	}
	return Params
end

--// -( Script entry )-

--// Refresh variables
LocalPlayer.CharacterAdded:Connect(CharacterAdded)
CharacterAdded(LocalPlayer.Character)
CameraPart.CFrame = Head.CFrame

--// Animation loop
local KeyDown = false
local IsTunneling = false
local Rot = 0

local function GetLookAt(From: CFrame): CFrame
	--// Load Config
	local Config = _G.Snail_Config

	local At = not IsMobile and Mouse.Hit or Camera:GetRenderCFrame()
	local Lookat = CFrame.lookAt(From.Position, At.Position)
	
	if IsMobile then --// Apply movement method used in V1 for mobile
		Lookat = Lookat * CFrame.Angles(0,math.rad(180),0)
	end

	return Lookat
end

local function TranslateCFrame(Original: CFrame): CFrame
	local _, Y = Original:ToOrientation()
	return CFrame.new(Original.Position) * CFrame.Angles(0,Y,0)
end

local function OffsetCFrame(Position: CFrame): CFrame
	--// Load Config
	local Config = _G.Snail_Config
	local Offset = Config.Offset 
	local TunnelOffset = Config.TunnelOffset 

	if IsTunneling then
		Offset = Offset * TunnelOffset
	end

	--// Process CFrames
	local NewPosition = GetLookAt(Position * Offset)
	CameraPart.CFrame = Position -- Set Camera focus CFrame

	return TranslateCFrame(NewPosition)
end

local function SnailMove(NoMouse: false)

	--// Load Config
	local Config = _G.Snail_Config
	local Speed = IsTunneling and Config.TunnelSpeed or Config.Speed
	local RotationEffect = Config.RotationEffect
	local DistSpeed = Config.DistanceChangesSpeed

	--// Calculate CFrames
	local MouseCFrame = not NoMouse and Mouse.Hit or CameraPart.CFrame

	--// Distance controlled speed
	if DistSpeed then
		local MaxDistance = Config.Distance
		local Distance = (CameraPart.Position - MouseCFrame.Position).magnitude
		Speed = Speed * math.clamp(Distance / MaxDistance, 0, 1)
	end

	local SpeedCFrame = CFrame.new(0, 0, -Speed)
	local rayDirection = Vector3.new(0, -Config.Max_Height, 0) 
	local RootOffset = CFrame.new(0, Config.Root_Height, 0)

	local rayOrigin = (GetLookAt((CameraPart.CFrame * RootOffset)) * SpeedCFrame).Position

	--// Create Raycast
	local raycastResult = workspace:Raycast(
		rayOrigin, 
		rayDirection, 
		raycastParams
	)

	--// Apply new CFrame
	if raycastResult then
		Rot += Speed/4

		local Position = CFrame.new(raycastResult.Position)
		local Turn = RotationEffect and math.sin(Rot) * 10 or 0
		local Rotation = CFrame.Angles(0,0,math.rad(Turn))

		Root.CFrame = OffsetCFrame(Position) * Rotation
	end
end
RunService.RenderStepped:Connect(function()
	if not KeyDown then return end
	SnailMove()
end)
SnailMove()

--// Process user keyboard input events
local function RequestTeleport(_, inputState, a)
	if inputState == Enum.UserInputState.End then
		HighlightPart.Transparency = 1
		return
	end
	if inputState ~= Enum.UserInputState.Begin then
		return
	end
	
	--// Highlight teleport location
	HighlightPart.Transparency = 0
	
	--// Loop until selected
	repeat
		HighlightPart.CFrame = CFrame.new(Mouse.Hit.Position)
		RunService.RenderStepped:Wait()
	until HighlightPart.Transparency == 1

	Root.CFrame = OffsetCFrame(HighlightPart.CFrame)
	PlaySound(Sounds["Teleport"])
end

--// Snail tunning
local function RequestTunnel(_, inputState)
	local Config = _G.Snail_Config
	
	if Config.TunnelIsToggle then
		if inputState ~= Enum.UserInputState.Begin then return end
		IsTunneling = not IsTunneling
	else
		IsTunneling = inputState == Enum.UserInputState.Begin
	end
	
	SnailMove(true) -- Update the position
	
	if IsMobile then
		KeyDown = IsTunneling
	end

	--// Play sound
	if IsTunneling then
		PlaySound(Sounds["Tunnel"])
	else
		StopSound(Sounds["Tunnel"])
	end
end

local function RequestMove(_, inputState)
	KeyDown = inputState == Enum.UserInputState.Begin
end

local function ResetCamera(_, inputState)
	if inputState ~= Enum.UserInputState.Begin then return end
	CameraPart.CFrame = Head.CFrame
	Camera.CameraSubject = CameraPart
end

--// Connect functions to input events
local SnailMove = "SnailMove"
ContextActionService:BindAction(
	SnailMove, 
	RequestMove, 
	true,
	Enum.UserInputType.MouseButton1
)
ContextActionService:SetImage(
	SnailMove, 
	"rbxassetid://5985993007"
)

local SnailTunnel = "SnailTunnel"
ContextActionService:BindAction(
	SnailTunnel, 
	RequestTunnel, 
	true,
	Config.Tunnel
)
ContextActionService:SetImage(
	SnailTunnel, 
	"rbxassetid://10104327834"
)

ContextActionService:BindAction(
	"SnailTeleport", 
	RequestTeleport, 
	false,
	Config.Teleport
)
ContextActionService:BindAction(
	"SnailResetCamera", 
	ResetCamera, 
	false,
	Config.ResetCamera
)
