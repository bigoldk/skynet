﻿local TestCharacter = {
	Information = {
		Index = 9999,
		Ename = "TestCharacter",
		Name = '测试角色',
		Description = '',
		Cost = 25,
		MaxStar = 5,
		Profession = 'DPS',
	 Sex = "Male",
 },
Skeleton = {
  name = "honghaier",
  actions = {
  idle = {"idle", 40},
  run = {"run", 24},
  victory = {"victory", 24},
  death = {"death", 43},
  smitten = {"smitten", 22},
  normalatkQian = {"normalatkQian", 26},
  normalatkHou = {"normalatkHou", 20},
  superatkQian = {"superatkQian", 18},
  superatkHou = {"superatkHou", 79},
  normalDandao = 8,
  superDandao = 76,
  },
 },
	Ability = {
		BaseAtk = 130,
		BaseMiss = 5,
		DeltaMiss = 0,
		DeltaAtk = 10, 
		BaseDef = 20, 
		DeltaDef = 2, 
		BaseHp = 170, 
		DeltaHp = 30, 
		MoveFriend = 9999,
		MoveEnemy = 1, 
		MovePreference = 0, 
 	},
 	Resistance = {
		Stun = 0,
		Freeze = 0,
		Disarm = 0,
		Poison = 0,
		Bleeding = 0,
		CriticalDamage = 0,
 	},
 	NormalAtk = {
		Name = '测试技能1',
		Description = '',
		Range = {{-4,0}},
		HitType = "ground",
		Speed = 120,
		HitPerBox = 1,
		CriP = 0.05,
		CriV = 1,
		ReceiverIsFriend = false,
		EffectToR = {
	 		Type = 1,
	 		BaseNumber = 37.44,
	 		DeltaNumber = 0,  
	 		Buffs = {
				Atk = {
	 				BaseTime = 2,
	 				DeltaTime = 0,
	 				BaseNumber = -30,
	 				DeltaNumber = -1,
	 				BaseSuccess = 50,
	 				DeltaSuccess = 0,
	 				IsGoodBuff = false,
				},     
	 		},
	 		Special = {
	 			Displace = {
	 				Distance = {{-1, 0},{-2, 0},{-3, 0}},
	 				PointRefX = "Self",
	 				PointRefY = "Self",
	 			},
	 		},
		},
		EffectToC = {
	 		Type = 0, 
	 		BaseNumber = 0, 
	 		DeltaNumber = 0, 
	 		Buffs = { 
		
	 		},
		},
 	},
 	SuperAtk = {
		Name = '饮血',
		Description = '', 
		Range = {{-1,0}}, 
		HitType = "ground", 
		Speed = 20, 
		HitPerBox = 1, 
		CriP = 0.05, 
		CriV = 1.2, 
		ReceiverIsFriend = false,
		EffectToR = {
	 		Type = 1, 
	 		BaseNumber = 381.637562335721, 
	 		DeltaNumber = 0, 
	 		Special = 0, 
	 		Buffs = { 
				ResistCriticalDamage = {
	 				BaseTime = 3,
	 				DeltaTime = 0,
	 				BaseNumber = 10,
	 				DeltaNumber = 0.35,
	 				BaseSuccess = 35,
	 				DeltaSuccess = 0.1,
	 				IsGoodBuff = false,
				},    
	 		},
		},
		EffectToC = {
	 		Type = 5,
	 		BaseNumber = 25, 
	 		DeltaNumber = 0.1,  
	 		Buffs = { 
		
	 		},
		},
		CD = 5,
 	},
 	LeaderSkill = {
		Name = '枯骨逢春',
		Description = '所有buff攻击提升10%',
		EffectiveToType = {
		 	'BUFF',
		},
		Effect = {
	 		Atk = 10,
		},
 	},
 	CooperateSkill = {},
}
return TestCharacter
