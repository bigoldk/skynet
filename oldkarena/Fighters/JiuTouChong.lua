local JiuTouChong = {
 Information = {
  Index = 14,
  Ename = 'JiuTouChong',
  Name = '九头虫',
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
  BaseAtk = 142.973688065114,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.7397187177163, 
  BaseDef = 20.593732337199, 
  DeltaDef = 1.0177611715725, 
  BaseHp = 171.896369030461, 
  DeltaHp = 30.7599619680846, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 12,
  Freeze = 0,
  Disarm = 12,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '九头击',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 9,
  CriP = 0.05,
  CriV = 2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 27.504,
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
  Name = '碧波万顷',
  Description = '', 
  Range = {{-1,0},{-2,0},{-2,-1},{-2,1},{-3,0},{-3,-1},{-3,-2},{-3,1},{-3,2}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 180.50584460587, 
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
  CD = 10,
 },
 LeaderSkill = {
  Name = '无影无踪',
  Description = '所有dps提升10%miss概率',
  EffectiveToType = {
   'DPS',
  },
  Effect = {
   




Miss = 10,






  },
 },
 CooperateSkill = {},
}

return JiuTouChong
