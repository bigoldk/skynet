local FighterTemplate = {
	-- required
	Information = {
		Index = 0,
		Ename = "FighterTemplate",
		Name = "角色模板",
		Description = "角色模板",
		Type = "Fire",
		Cost = 25,
		MaxStar = 5,
		Profession = "DPS",
		Sex = "Male",
	},
	Skeleton = {
  		name = "FighterTemplate",
 	 	actions = {
  		idle = {"idle", 40},
  		run = {"run", 24},
  		victory = {"victory", 24},
  		death = {"death", 43},
  		smitten = {"smitten", 22},
  		normalatkQian = {"normalatkQian", 26},
  		normalatkHou = {"normalatkHou", 20},
  		superatk = {"superatk", 55},
  		},
 	},	-- required
	Ability = {
		BaseAtk = 0, -- atk
		DeltaAtk = 0, -- atk grow
		BaseDef = 0, -- def
		DeltaDef = 0, -- def grow
		BaseHp = 0, -- hp
		DeltaHp = 0, -- hp grow
		BaseMiss = 0,
		DeltaMiss = 0,
		AbilityRating = 0,
		MoveFriend = 0, -- move range of fighter in friend camp
		MoveEnemy = 0, -- move range of fighter in enemy camp
		MovePreference = 0, -- if the fighter can make a turn 
	},
	-- required
	Resistance = {
		Stun = 0,
		Freeze = 0,
		Disarm = 0,
		Poison = 0,
		Bleeding = 0,
		CriticalDamage = 0,
		Burning = 0,
		ResistanceRating = 0,
	},
	CookSkill = {skill = {type = "baoji",prob = 50,food = "zhurou"}},
	-- required
	NormalAtk = 
	{
		Name = "NULL",
		Description = "NULL",
		--白色
		{
			Range = {{0,0}}, -- skill range, in 2-dimension matrix form
			HitType = "ground", -- 0 is normal, 1 is flying
			Speed = 0, -- atk speed
			HitPerBox = 0, -- hit per box
			CriP = 0, -- critical hit possibility
			CriV = 0, -- critical hit addtion number
			ReceiverIsFriend = false,			
			EffectToR = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0,
				-- optional
				Buffs = { -- buff to receiver
					--[[BuffKeys : Miss, Hp, Atk, Def, CriP, CriV, MoveAbility, MovePreference, ResistStun, ResistFreeze, 
					ResistDisarm, ResistBleeding, ResistCriticalDamage, ResistPoison, ResistBurning, HitRate,
					Stun, Freeze, Disarm, Burning, Poison, Bleeding, Chaos,-- debuffs
					ContinuingHeal, Immune, Invincible, ActTwice, CounterAttack, DamageRebound, --buffs]]
					BuffKey = {
						BaseTime = 0,
						DeltaTime = 0,
						BaseNumber = 0,
						DeltaNumber = 0,
						BaseSuccess = 0,
						DeltaSuccess = 0,
						IsGoodBuff = false,
					},
				},
			},
			EffectToC = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0, -- tmp: for beat off
				-- optional
				Buffs = { -- buff to receiver			
				},
			},
			Rating1 = 0,
			Rating2 = 0,
			Rating3 = 0,
		},
			---绿色
		{
			Range = {{0,0}}, -- skill range, in 2-dimension matrix form
			HitType = "ground", -- 0 is normal, 1 is flying
			Speed = 0, -- atk speed
			HitPerBox = 0, -- hit per box
			CriP = 0, -- critical hit possibility
			CriV = 0, -- critical hit addtion number
			ReceiverIsFriend = false,
			EffectToR = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0,
				-- optional
				Buffs = { -- buff to receiver
				}
			},
			EffectToC = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0, -- tmp: for beat off
				Buffs = {
				},
			},
			Rating1 = 0,
			Rating2 = 0,
			Rating3 = 0,
		},
		---蓝色
		{
			Range = {{0,0}}, -- skill range, in 2-dimension matrix form
			HitType = "ground", -- 0 is normal, 1 is flying
			Speed = 0, -- atk speed
			HitPerBox = 0, -- hit per box
			CriP = 0, -- critical hit possibility
			CriV = 0, -- critical hit addtion number
			ReceiverIsFriend = false,
			EffectToR = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0,
				-- optional
				Buffs = { -- buff to receiver
				}
			},
			EffectToC = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0, -- tmp: for beat off
				Buffs = {
				},
			},
			Rating1 = 0,
			Rating2 = 0,
			Rating3 = 0,
		},
		---紫色
		{
			Range = {{0,0}}, -- skill range, in 2-dimension matrix form
			HitType = "ground", -- 0 is normal, 1 is flying
			Speed = 0, -- atk speed
			HitPerBox = 0, -- hit per box
			CriP = 0, -- critical hit possibility
			CriV = 0, -- critical hit addtion number
			ReceiverIsFriend = false,
			EffectToR = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0,
				-- optional
				Buffs = { -- buff to receiver
				}
			},
			EffectToC = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0, -- tmp: for beat off
				Buffs = {
				},
			},
			Rating1 = 0,
			Rating2 = 0,
			Rating3 = 0,
		},
		---橙色
		{
			Range = {{0,0}}, -- skill range, in 2-dimension matrix form
			HitType = "ground", -- 0 is normal, 1 is flying
			Speed = 0, -- atk speed
			HitPerBox = 0, -- hit per box
			CriP = 0, -- critical hit possibility
			CriV = 0, -- critical hit addtion number
			ReceiverIsFriend = false,
			EffectToR = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0,
				-- optional
				Buffs = { -- buff to receiver
				}
			},
			EffectToC = {
				Type = 0, -- effect type to receiver 0: none; 1:c-atk%; 2:r-current hp%; 3:r-total hp%; 4:fixed;
				BaseNumber = 0, -- base number of atk to receiver
				DeltaNumber = 0, -- delta number of atk to receiver
				Special = 0, -- tmp: for beat off
				Buffs = {
				},
			},
			Rating1 = 0,
			Rating2 = 0,
			Rating3 = 0,
		},
	},
	-- required
	SuperAtk = {
		--此处同NormalAtk
		CD = 0,
	},
	GeneralRating1 = 0,
	GeneralRating2 = 0,
	GeneralRating3 = 0,
	GeneralRating4 = 0,

	-- optional
	-- LeaderSkill = {
	-- 	EffectiveToType = {
	-- 		"Metal",
	-- 		"Wood",
	-- 		"Water",
	-- 		"Fire",
	-- 		"Earth",
	-- 		"DPS",
	-- 		"TANK",
	-- 		"BUFF",
	-- 	},
	-- 	Effect = {
	-- 		Miss = 0,
	-- 		Atk = 0,
	-- 		Def = 0,
	-- 		Hp = 0,
	-- 		CriP = 0,
	-- 		CriV = 0,
	-- 		ResistStun = 0,
	-- 		ResistFreeze = 0,
	-- 		ResistDisarm = 0,
	-- 		ResistPoison = 0,
	-- 		ResistBleeding = 0,
	-- 		ResistCriticalDamage = 0,
	-- 	},
	-- },
	-- CooperateSkill = {},
}

return FighterTemplate