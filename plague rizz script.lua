--[[
	████████████████████████████████████████
	████████████████████████████████████████
	██████▀░░░░░░░░▀████████▀▀░░░░░░░▀██████
	████▀░░░░░░░░░░░░▀████▀░░░░░░░░░░░░▀████
	██▀░░░░░░░░░░░░░░░░▀▀░░░░░░░░░░░░░░░░▀██
	██░░░░░░░░░░░░░░░░░░░▄▄░░░░░░░░░░░░░░░██
	██░░░░░░░░░░░░░░░░░░█░█░░░░░░░░░░░░░░░██
	██░░░░░░░░░░░░░░░░░▄▀░█░░░░░░░░░░░░░░░██
	██░░░░░░░░░░████▄▄▄▀░░▀▀▀▀▄░░░░░░░░░░░██
	██▄░░░░░░░░░████░░░░░░░░░░█░░░░░░░░░░▄██
	████▄░░░░░░░████░░░░░░░░░░█░░░░░░░░▄████
	██████▄░░░░░████▄▄▄░░░░░░░█░░░░░░▄██████
	████████▄░░░▀▀▀▀░░░▀▀▀▀▀▀▀░░░░░▄████████
	██████████▄░░░░░░░░░░░░░░░░░░▄██████████
	████████████▄░░░░░░░░░░░░░░▄████████████
	██████████████▄░░░░░░░░░░▄██████████████
	████████████████▄░░░░░░▄████████████████
	██████████████████▄▄▄▄██████████████████
	████████████████████████████████████████
	████████████████████████████████████████
	
	Depso - mastersmzscripts.com
	This script cannot guarantee girls or men
    Shoutout to plague for the hella rizz
    
    the previous sounds used do not work outside of studio
    so i had to change them last minute
]]

local The_Plague = {
	"this is tough and rough !1",
	"im a good guy yk !1",
	"are you a plague? Because if yes then don't get near me",
	"wait till MasterMZ finds out",
	"are you a skibidi mogger?? ?? cuz if yes then you can have myyyy grimace shake!1",
	"are you a mogger?? Because if yes, then you could fanum tax me anytime 😨😨🙏",
	"are you a plague?11??? because if yes,,,, then im attracted to you",
	"Erm......a.aw..w...... what the sigma??1?1",
	"i see what you're tryna do !1",
	"Are you a sigma!1!1??? Because you skibidi my world (real)",
	"you are the subspace tripmine to my heart",
	"you're the cold cup of water at 4 am night (and yes everytime!1)",
	"mary mi !1",
	"let's recreate the funny 50k dollar animation video together but you're the one chasing after me !1",
	"I’d call an emergency meeting just to spend more time with you. (with rizz)",
	"Hey, are you a vent? Because I’m the imposter and I’d love to come in you",
	"would you rather be a sigma or a rizzler!1??????",
	"fortnite battlepass grimace skin is out guys !1",
}

local The_Ulimate_Rizz = {
	"be my partner in life !1",
}

local Sounds = {
	Mogged = 12221944, -- 17552328874
	ByeBye = 9072301639,-- 17545105731,
	Concrete_Move = 8060727735
}


------------

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local DebrisService = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

-- Effects
local Brightness_Effect = Instance.new("ColorCorrectionEffect", Lighting)
local Camera = workspace.CurrentCamera
local Original_FOV = Camera.FieldOfView
local Rand = Random.new(os.clock())
local Rizz_Count = 0

-- UI Elements
local ScreenGui = Instance.new("ScreenGui")
local PanicForSigmaRizz = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
local UICorner = Instance.new("UICorner")
local Ulimate = Instance.new("TextButton")
local UIGradient_2 = Instance.new("UIGradient")
local UICorner_2 = Instance.new("UICorner")
local W = Instance.new("TextLabel")
local UIGradient_3 = Instance.new("UIGradient")

ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local PanicStroke = Instance.new("UIStroke", PanicForSigmaRizz)
PanicStroke.Thickness = 3
PanicStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
PanicStroke.Color = Color3.fromRGB(58, 0, 0)

PanicForSigmaRizz.Name = "PanicForSigmaRizz"
PanicForSigmaRizz.Parent = ScreenGui
PanicForSigmaRizz.AnchorPoint = Vector2.new(0, 1)
PanicForSigmaRizz.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PanicForSigmaRizz.BorderColor3 = Color3.fromRGB(0, 0, 0)
PanicForSigmaRizz.BorderSizePixel = 0
PanicForSigmaRizz.Position = UDim2.new(0, 20, 1, -20)
PanicForSigmaRizz.Size = UDim2.new(0, 100, 0, 100)
PanicForSigmaRizz.ZIndex = 10
PanicForSigmaRizz.Font = Enum.Font.FredokaOne
PanicForSigmaRizz.Text = "Rizz"
PanicForSigmaRizz.TextSize = 47.000
PanicForSigmaRizz.TextWrapped = true

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(249, 1, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(96, 0, 0))}
UIGradient.Rotation = 90
UIGradient.Parent = PanicForSigmaRizz

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = PanicForSigmaRizz

local UlimateStroke = Instance.new("UIStroke", Ulimate)
UlimateStroke.Thickness = 3
UlimateStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UlimateStroke.Color = Color3.fromRGB(58, 46, 0)

Ulimate.Name = "Ulimate"
Ulimate.Parent = PanicForSigmaRizz
Ulimate.BackgroundColor3 = Color3.fromRGB(255, 247, 0)
Ulimate.BorderColor3 = Color3.fromRGB(0, 0, 0)
Ulimate.BorderSizePixel = 0
Ulimate.Position = UDim2.new(0, 10, 0, 0)
Ulimate.Size = UDim2.new(0, 100, 0, 100)
Ulimate.Visible = false
Ulimate.ZIndex = 5
Ulimate.Font = Enum.Font.FredokaOne
Ulimate.Text = "SIGMA"
Ulimate.TextSize = 30.000
Ulimate.TextWrapped = true

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(249, 249, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(130, 130, 130))}
UIGradient_2.Rotation = 90
UIGradient_2.Parent = Ulimate

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = Ulimate

W.Name = "W"
W.Parent = ScreenGui
W.AnchorPoint = Vector2.new(0.5, 0.5)
W.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
W.BackgroundTransparency = 1.000
W.BorderColor3 = Color3.fromRGB(0, 0, 0)
W.BorderSizePixel = 0
W.Position = UDim2.new(0.123000003, 0, 0, 0)
W.Size = UDim2.new(0, 50, 0, 50)
W.Visible = false
W.Font = Enum.Font.FredokaOne
W.Text = "W"
W.TextColor3 = Color3.fromRGB(249, 1, 0)
W.TextScaled = true
W.TextSize = 100.000
W.TextStrokeTransparency = 0.500
W.TextWrapped = true

UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(249, 249, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(130, 130, 130))}
UIGradient_3.Rotation = 90
UIGradient_3.Parent = W

for Name, Id in next, Sounds do
	local Sound = Instance.new("Sound", workspace)
	Sound.SoundId = `rbxassetid://{Id}`
	Sound.Volume = 1
	Sounds[Name] = Sound
end

local function Say(Message: string)
	ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
		Message, 
		"All" -- Text channel
	)
end

local function PickRand(Table: SharedTable)
	return Table[math.random(1, #Table)]
end

local function Create_Tweens(TweenInfo, Instances)
	local Tweens = {}
	for Instance, Props in next, Instances do
		local Tween = TweenService:Create(Instance, TweenInfo, Props)
		table.insert(Tweens, Tween)
	end

	return setmetatable({}, {
		__index = function(self, key)
			local Value = Tweens[1][key]

			if typeof(Value) == "function" then
				return function(...)
					for _, Tween in next, Tweens do
						Tween[key](Tween, ...)
					end
				end
			end

			return Value
		end,
	})
end

local function Show_UlimateRizz()
	local Sound: Sound = Sounds.Concrete_Move
	Sound:Play()

	local _TweenInfo = TweenInfo.new(Sound.TimeLength, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	Ulimate.Position = UDim2.new()
	Ulimate.Visible = true
	Ulimate.Active = false
	Ulimate.Position = UDim2.new(0, 0, 0, 0)
	Ulimate.BackgroundTransparency = 0.5

	local Tween = Create_Tweens(_TweenInfo, {
		[Ulimate] = {
			Position = UDim2.new(1, 10,0, 0),
			BackgroundTransparency = 0	
		}
	})
	Tween:Play()
	Tween.Completed:Wait()

	Ulimate.Active = true
end

local function Create_Dub()
	local _TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local NewDub = W:Clone()

	local p = PanicForSigmaRizz.AbsolutePosition
	local s = PanicForSigmaRizz.Size

	NewDub.Parent = ScreenGui
	NewDub.Visible = true
	NewDub.Position = PanicForSigmaRizz.Position + UDim2.new(0,s.X.Offset/2,0,-s.Y.Offset/2)

	local Tween = Create_Tweens(_TweenInfo, {  -- Cheap method
		[NewDub] = {
			Position = UDim2.new(0, p.X+Rand:NextInteger(0, 300), 0, p.Y+Rand:NextInteger(-200, 0)),
			TextTransparency = 1	
		}
	})
	Tween:Play()
	Tween.Completed:Connect(function()
		NewDub:Remove()
	end)
end

Ulimate.Activated:Connect(function()
	local _TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

	Ulimate.Visible = false

	Create_Tweens(_TweenInfo, {
		[Camera] = {
			FieldOfView = 0
		},
		[PanicForSigmaRizz] = {
			Position = UDim2.new(0, 20, 1, 100)
		},
		[Brightness_Effect] = {
			Brightness = -1
		}
	}):Play()

	wait(1)
	Sounds.ByeBye:Play()

	local Rizz = PickRand(The_Ulimate_Rizz)
	Say(Rizz)

	-- Long fade
	local Long_TweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	Create_Tweens(Long_TweenInfo, {
		[PanicForSigmaRizz] = {
			Position = UDim2.new(0, 20, 1, -20)
		},
		[Brightness_Effect] = {
			Brightness = 0
		}
	}):Play()

	Create_Tweens(_TweenInfo, {
		[PanicForSigmaRizz] = {
			Position = UDim2.new(0, 20, 1, -20)
		}
	}):Play()

	-- repeat
	-- 	TweenService:Create(Camera, _TweenInfo, {
	-- 		FieldOfView = math.clamp(ByeBye.PlaybackLoudness/3, Original_FOV, 100)
	-- 	}):Play()
	-- 	task.wait()
	-- until not ByeBye.IsPlaying 

	Rizz_Count = 0
end)

PanicForSigmaRizz.Activated:Connect(function()
	local Mogged: Sound = Sounds.Mogged
	local _TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

	local Rizz = PickRand(The_Plague)
	Say(Rizz)

	Create_Dub()
	Mogged:Play()
	Rizz_Count += 1

	if Rizz_Count == 10 then -- 10 Easy, 20 Hard, 50 Thomas Shebly
		Show_UlimateRizz() 
		return
	end

	Camera.FieldOfView = 100 -- CHANGE ME 
	Create_Tweens(_TweenInfo, {
		[Camera] = {
			FieldOfView = Original_FOV
		}
	}):Play()
end)

