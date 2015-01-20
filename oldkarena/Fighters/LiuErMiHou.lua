local LiuErMiHou = {
 Information = {
  Index = 2,
  Ename = 'LiuErMiHou',
  Name = '六耳猕猴',
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
  BaseAtk = 100.8,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.2, 
  BaseDef = 16, 
  DeltaDef = 1.3, 
  BaseHp = 249.666666666667, 
  DeltaHp = 33.6, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 60,
  Poison = 5,
  Bleeding = 5,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '力压千钧',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 8.5,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 63.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 30,
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
 },
 SuperAtk = {
  Name = '小杀四方',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 5, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 115.081587051434, 
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
  CD = 3,
 },
 LeaderSkill = {
  Name = '真伪难辨',
  Description = '己方队员增加5%miss概率',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   




Miss = 5,






  },
 },
 CooperateSkill = {},
}

return LiuErMiHou
