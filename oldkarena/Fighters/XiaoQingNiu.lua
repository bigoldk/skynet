<<<<<<< HEAD:app/data/Fighters/XiaoQingNiu.lua
﻿local XiaoQingNiu = {
 Information = {
  Index = 15,
  Ename = 'XiaoQingNiu',
  Name = '小青牛',
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
  BaseAtk = 146.954125010871,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.6634446810495, 
  BaseDef = 21.4402470184231, 
  DeltaDef = 1.05675524627114, 
  BaseHp = 173.26693755925, 
  DeltaHp = 30.827633229893, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 5,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '奔腾突袭',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 86.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
            
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
  Name = '圈里乾坤',
  Description = '', 
  Range = {{-1,1},{-1,0},{-1,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 292.914983741434, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Disarm = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 25,
     DeltaSuccess = 0.25,
     IsGoodBuff = false,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '木之将领',
  Description = '所有木系攻防提升5%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return XiaoQingNiu
=======
local SiDaWang = {
 Information = {
  Index = 15,
  Ename = SiDaWang,
  Name = '兕大王',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
 },
 Ability = {
  BaseAtk = 146.954125010871,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.6634446810495, 
  BaseDef = 21.4402470184231, 
  DeltaDef = 1.05675524627114, 
  BaseHp = 173.26693755925, 
  DeltaHp = 30.827633229893, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 5,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '奔腾突袭',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 86.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
            
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
  Name = '圈里乾坤',
  Description = '', 
  Range = {{-1,-1},{-1,0},{-1,1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 292.914983741434, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Disarm = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 25,
     DeltaSuccess = 0.25,
     IsGoodBuff = false,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '木之将领',
  Description = '所有木系攻防提升5%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return SiDaWang
>>>>>>> FengYi:app/data/Fighters/SiDaWang.lua
