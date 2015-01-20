<<<<<<< HEAD
﻿local TangSeng = {
 Information = {
  Index = 27,
  Ename = 'TangSeng',
  Name = '唐僧',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
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
  BaseAtk = 128,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 8.13, 
  BaseDef = 15.5335847308683, 
  DeltaDef = 1.00920245239242, 
  BaseHp = 137.268993331671, 
  DeltaHp = 24.9929103156456, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 100,
  Bleeding = 100,
  CriticalDamage = 100,
 },
 NormalAtk = {
  Name = '金蝉护盾',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -86,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 30,
     DeltaNumber = 1,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = true,
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
  Name = '佛法无边',
  Description = '', 
  Range = 'All', 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -131.847616864613, 
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
  CD = 4,
 },
 LeaderSkill = {
  Name = '圣音缭绕',
  Description = '所有buff暴击率提升10%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   


CriP = 10,








  },
 },
 CooperateSkill = {},
}

return TangSeng
=======
local TangSeng = {
 Information = {
  Index = 27,
  Ename = TangSeng,
  Name = '唐僧',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
 },
 Ability = {
  BaseAtk = 128,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 8.13, 
  BaseDef = 15.5335847308683, 
  DeltaDef = 1.00920245239242, 
  BaseHp = 137.268993331671, 
  DeltaHp = 24.9929103156456, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 100,
  Bleeding = 100,
  CriticalDamage = 100,
 },
 NormalAtk = {
  Name = '金蝉护盾',
  Description = '',
  Range = {{-1,-1},{-1,0},{-1,1}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -86,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 30,
     DeltaNumber = 1,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = true,
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
  Name = '佛法无边',
  Description = '', 
  Range = {"all friends"}, --all friends, 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -131.847616864613, 
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
  CD = 4,
 },
 LeaderSkill = {
  Name = '圣音缭绕',
  Description = '所有buff暴击率提升10%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   


CriP = 10,








  },
 },
 CooperateSkill = {},
}

return TangSeng
>>>>>>> FengYi
