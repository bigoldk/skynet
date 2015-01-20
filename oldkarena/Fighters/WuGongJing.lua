<<<<<<< HEAD
﻿local WuGongJing = {
 Information = {
  Index = 24,
  Ename = 'WuGongJing',
  Name = '蜈蚣精',
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
  BaseAtk = 159.622589375192,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.3888066260151, 
  BaseDef = 21.0703020613582, 
  DeltaDef = 1.20877208122481, 
  BaseHp = 166.400993259011, 
  DeltaHp = 27.1606607170105, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 40,
  Bleeding = 10,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '百足斩',
  Description = '',
  Range = {{-4,1},{-4,0},{-4,-1}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 92.64,
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
  Name = '千眼金光',
  Description = '', 
  Range = 'All', 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 173.69401875536, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Bleeding = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = -40,
     DeltaNumber = -8,
     BaseSuccess = 40,
     DeltaSuccess = 0.15,
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
  Name = '火之将领',
  Description = '所有火系攻防提升5%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return WuGongJing
=======
local WuGongJing = {
 Information = {
  Index = 24,
  Ename = WuGongJing,
  Name = '蜈蚣精',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
 },
 Ability = {
  BaseAtk = 159.622589375192,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.3888066260151, 
  BaseDef = 21.0703020613582, 
  DeltaDef = 1.20877208122481, 
  BaseHp = 166.400993259011, 
  DeltaHp = 27.1606607170105, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 40,
  Bleeding = 10,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '百足斩',
  Description = '',
  Range = {{-1,2},{-1,1},{-1,0},{-1,-1},{-1,-2}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 70.56,
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
  Name = '千眼金光',
  Description = '', 
  Range = {{-4,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 373.319820592507, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Bleeding = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = -40,
     DeltaNumber = -8,
     BaseSuccess = 40,
     DeltaSuccess = 0.15,
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
  Name = '火之将领',
  Description = '所有火系攻防提升5%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return WuGongJing
>>>>>>> FengYi
