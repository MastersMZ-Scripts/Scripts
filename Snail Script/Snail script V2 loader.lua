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
	The SNAIL Script V2
	
	To update the config, run the script again.
]]

_G.Snail_Config = {
	Speed = 0.4,
	TunnelSpeed = 2,

	--// Offsets
	Offset = CFrame.new(0,-1,0),
	TunnelOffset = CFrame.new(0,-2,0), -- This is added to the Offset

	--// Control
	Teleport = Enum.KeyCode.E,
	Tunnel = Enum.KeyCode.Q,
	ResetCamera = Enum.KeyCode.R,
	
	TunnelIsToggle = false,
	DistanceChangesSpeed = true,
	UseCameraRotaton = false, -- Old movement

	Distance = 5,
	
	--// Animations
	RotationEffect = false,
	Enabled = true, -- If disabled, the script will not run after death
	DirtParticles = true,
	Sounds = true,

	--// Trail Style
	Color = ColorSequence.new{ -- Time Position, Value
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 171, 3)), 
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(132, 255, 0))
	},
	Transparency = NumberSequence.new{ 
		NumberSequenceKeypoint.new(0.00, 0.40), 
		NumberSequenceKeypoint.new(1.00, 1.00)
	},
	Length = 0.3, -- 0: Disabled

	--// Dirt style
	DirtColor = ColorSequence.new{ -- Time Position, Value
		ColorSequenceKeypoint.new(0, Color3.fromRGB(193, 135, 0)), 
		ColorSequenceKeypoint.new(1, Color3.fromRGB(158, 84, 0))
	},
	DirtSize = NumberSequence.new{ 
		NumberSequenceKeypoint.new(0, 0.2), 
		NumberSequenceKeypoint.new(1, 0.25)
	},

	--// Sounds
	Audios = {
		Teleport = {
			SoundId = 507863457
		},
		Tunnel = {
			SoundId = 9114127078,
			Looped = true,
			PlaybackSpeed = 1.2
		},
	},

	--// Misc (Advanced)
	Max_Height = 15,
	Root_Height = 4,
}

------------------------------

if _G.Snail_Ran then return end
loadstring(game:HttpGet('https://raw.githubusercontent.com/MastersMZ-Scripts/Scripts/master/Snail%20Script/Snail%20Script%20V2.lua'))()
