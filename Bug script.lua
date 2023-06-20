-- https://www.roblox.com/catalog/5674273899/Giant-Isopod-Back-Accessory

repeat wait() until game:IsLoaded() == true

local rayDirection = Vector3.new(0, -100, 0)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {};
		FakeConnections = {};
		Connections = {};
		Output = {
			Enabled = true;
			Prefix = "[NETWORK] ";
			Send = function(Type,Output,BypassOutput)
				if typeof(Type) == "function" and (Type == print or Type == warn or Type == error) and typeof(Output) == "string" and (typeof(BypassOutput) == "nil" or typeof(BypassOutput) == "boolean") then
					if Network["Output"].Enabled == true or BypassOutput == true then
						Type(Network["Output"].Prefix..Output);
					end;
				end;
			end;
		};
		CharacterRelative = false;
	}

	Network["Output"].Send(print,": Loading.")
	Network["Velocity"] = Vector3.new(14.46262424,14.46262424,14.46262424); --exactly 25.1 magnitude
	Network["RetainPart"] = function(Part,ReturnFakePart) --function for retaining ownership of unanchored parts
		assert(typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace),Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg1 (Part) must be a BasePart which is a descendant of workspace.")
		assert(typeof(ReturnFakePart) == "boolean" or typeof(ReturnFakePart) == "nil",Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg2 (ReturnFakePart) must be a boolean or nil.")
		if not table.find(Network["BaseParts"],Part) then
			if Network.CharacterRelative == true then
				local Character = LocalPlayer.Character
				if Character and Character.PrimaryPart then
					local Distance = (Character.PrimaryPart.Position-Part.Position).Magnitude
					if Distance > 1000 then
						return false
					end
				else
					return false
				end
			end
			table.insert(Network["BaseParts"],Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
			if ReturnFakePart == true then
				return FakePart
			end
		else
			return false
		end
	end

	Network["RemovePart"] = function(Part) --function for removing ownership of unanchored part
		assert(typeof(Part) == "Instance" and Part:IsA("BasePart"),Network["Output"].Prefix.."RemovePart Error : Invalid syntax: Arg1 (Part) must be a BasePart.")
		local Index = table.find(Network["BaseParts"],Part)
		if Index then
			table.remove(Network["BaseParts"],Index)
		end
	end

	Network["SuperStepper"] = Instance.new("BindableEvent") --make super fast event to connect to
	for _,Event in pairs({RunService.Stepped,RunService.Heartbeat}) do
		Event:Connect(function()
			return Network["SuperStepper"]:Fire(Network["SuperStepper"],tick())
		end)
	end

	Network["PartOwnership"] = {};
	Network["PartOwnership"]["PreMethodSettings"] = {};
	Network["PartOwnership"]["Enabled"] = false;
	Network["PartOwnership"]["Enable"] = coroutine.create(function() --creating a thread for network stuff
		if Network["PartOwnership"]["Enabled"] == false then
			Network["PartOwnership"]["Enabled"] = true --do cool network stuff before doing more cool network stuff
			Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus = LocalPlayer.ReplicationFocus
			LocalPlayer.ReplicationFocus = workspace
			Network["PartOwnership"]["PreMethodSettings"].SimulationRadius = gethiddenproperty(LocalPlayer,"SimulationRadius")
			Network["PartOwnership"]["Connection"] = Network["SuperStepper"].Event:Connect(function() --super fast asynchronous loop
				sethiddenproperty(LocalPlayer,"SimulationRadius",1/0)
				for _,Part in pairs(Network["BaseParts"]) do --loop through parts and do network stuff
					coroutine.wrap(function()
						if Part:IsDescendantOf(workspace) then
							if Network.CharacterRelative == true then
								local Character = LocalPlayer.Character;
								if Character and Character.PrimaryPart then
									local Distance = (Character.PrimaryPart.Position - Part.Position).Magnitude
									if Distance > 1000 then
										Lost = true;
										Network["RemovePart"](Part)
									end
								end
							end
							Part.Velocity = Network["Velocity"]+Vector3.new(0,math.cos(tick()*10)/100,0)
						else
							Network["RemovePart"](Part)
						end
					end)()
				end
			end)
		end
	end)
	Network["PartOwnership"]["Disable"] = coroutine.create(function()
		if Network["PartOwnership"]["Connection"] then
			Network["PartOwnership"]["Connection"]:Disconnect()
			LocalPlayer.ReplicationFocus = Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus
			sethiddenproperty(LocalPlayer,"SimulationRadius",Network["PartOwnership"]["PreMethodSettings"].SimulationRadius)
			Network["PartOwnership"]["PreMethodSettings"] = {}
			for _,Part in pairs(Network["BaseParts"]) do
				Network["RemovePart"](Part)
			end
			Network["PartOwnership"]["Enabled"] = false
		end
	end)
end

coroutine.resume(Network["PartOwnership"]["Enable"])

local lp = game.Players.LocalPlayer -- local player var
local char = lp.Character -- char var

lp.Character = nil -- nil character for pdeath
lp.Character = char -- newvar

wait(game.Players.RespawnTime + .3) -- nil wait

--hrp:Destroy() -- rip hrp
--char.Torso:Destroy() -- rip torso
local clone = char["Body Colors"]:Clone() -- body colors clone
char["Body Colors"]:Destroy() -- delete any instances from char that replicates deletion
clone.Parent = char -- parent back in clone in case some script uses it



local UserInputService = game:GetService("UserInputService")
local Character = char

local Bug = Character["Giant Isopod"].Handle

local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {Character, Bug}
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local Camera = workspace.CurrentCamera
Camera.CameraSubject = Bug

local t = 5
local KeyDown = false
local BUGCFRAME = Character.Head.CFrame

game:GetService("RunService").RenderStepped:Connect(function()
	if KeyDown then
		local rayOrigin = (CFrame.lookAt(Bug.CFrame.Position+Vector3.new(0,2,0), Camera.CFrame.Position) * CFrame.new(0,0,1)).Position
		local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

		if raycastResult then
			BUGCFRAME=CFrame.new(raycastResult.Position)*CFrame.new(0,Bug.Size.Y/2,0)
		end
	end
end)

--Bug:BreakJoints()

Network.RetainPart(Bug)
Bug.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
Bug.CanCollide = false

for i,v in pairs(char:GetDescendants()) do
    pcall(function()
        if v:IsA("BasePart") and v.Parent:IsA("Accessory") == false then
    		v:Destroy()
    	end
    end)
end

game:GetService("RunService").RenderStepped:Connect(function()
	local camRotation = math.atan2(-Camera.CFrame.LookVector.X, -Camera.CFrame.LookVector.Z) - (Camera.CFrame.LookVector.X/4.3)-- X Rotation mixed with Z Rotation

	Bug.CFrame = BUGCFRAME * CFrame.Angles(0,camRotation,0)
end)


UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		KeyDown = true
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		KeyDown = false
	end
end)
