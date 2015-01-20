<<<<<<< HEAD:app/data/Fighters/XiaoEYu.lua
﻿local XiaoEYu = {
 Information = {
  Index = 25,
  Ename = 'XiaoEYu',
  Name = '小鳄鱼',
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
  BaseAtk = 141.532769648747,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.0313197436667, 
  BaseDef = 20.4474210192598, 
  DeltaDef = 1.17234370968482, 
  BaseHp = 155.405319285037, 
  DeltaHp = 30.6999989076001, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 15,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '鳄吻',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 3,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 52.16,
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
  Name = '化龙',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 3, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 215.282727471432, 
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '土之将领',
  Description = '所有土系攻防提升5%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return XiaoEYu
=======
local QiuLong = {
 Information = {
  Index = 25,
  Ename = QiuLong,
  Name = '鼍龙',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
 },
 Ability = {
  BaseAtk = 141.532769648747,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.0313197436667, 
  BaseDef = 20.4474210192598, 
  DeltaDef = 1.17234370968482, 
  BaseHp = 155.405319285037, 
  DeltaHp = 30.6999989076001, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 15,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '鳄吻',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 3,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 52.16,
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
  Name = '化龙',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 3, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 215.282727471432, 
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '土之将领',
  Description = '所有土系攻防提升5%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return QiuLong
>>>>>>> FengYi:app/data/Fighters/QiuLong.lua
