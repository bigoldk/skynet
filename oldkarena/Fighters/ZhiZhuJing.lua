local ZhiZhuJing = {
 Information = {
  Index = 23,
  Ename = 'ZhiZhuJing',
  Name = '蜘蛛精',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
  Sex = "Female",
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
  BaseAtk = 154.069763444441,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.853752092818, 
  BaseDef = 20.2002368453475, 
  DeltaDef = 1.05478335114542, 
  BaseHp = 167.480498997934, 
  DeltaHp = 31.9008670651898, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 10,
  Disarm = 15,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '盘丝缚体',
  Description = '',
  Range = {{-2,1},{-2,0},{-2,-1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 3,
  CriP = 0.2,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 41.12,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Freeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 30,
     DeltaSuccess = 0.05,
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
 },
 SuperAtk = {
  Name = '情网',
  Description = '', 
  Range = {{-2,0},{-3,0},{-4,0},{-2,1},{-3,1},{-4,1},{-2,-1},{-3,-1},{-4,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 151.513374106788, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Freeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 10,
     DeltaSuccess = 0.2,
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
  Name = '土之先锋',
  Description = '所有土系暴击率miss率提升5%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return ZhiZhuJing
local ZhiZhuJing = {
 Information = {
  Index = 23,
  Ename = 'ZhiZhuJing',
  Name = '蜘蛛精',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
 },
 Ability = {
  BaseAtk = 154.069763444441,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.853752092818, 
  BaseDef = 20.2002368453475, 
  DeltaDef = 1.05478335114542, 
  BaseHp = 167.480498997934, 
  DeltaHp = 31.9008670651898, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 10,
  Disarm = 15,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '盘丝缚体',
  Description = '',
  Range = {{-2,1},{-2,0},{-2,-1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 3,
  CriP = 0.2,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 41.12,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Freeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 30,
     DeltaSuccess = 0.05,
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
 },
 SuperAtk = {
  Name = '情网',
  Description = '', 
  Range = {{-2,0},{-3,0},{-4,0},{-2,1},{-3,1},{-4,1},{-2,-1},{-3,-1},{-4,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 151.513374106788, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Freeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 10,
     DeltaSuccess = 0.2,
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
  Name = '土之先锋',
  Description = '所有土系暴击率miss率提升5%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return ZhiZhuJing
