local NiuMoWang = {
 Information = {
  Index = 36,
  Ename = 'NiuMoWang',
  Name = '牛魔王',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'TANK',
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
  BaseAtk = 102.251939919482,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.64655983048644, 
  BaseDef = 32.5, 
  DeltaDef = 2.19112769335195, 
  BaseHp = 402.166666666667, 
  DeltaHp = 68, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 40,
  Freeze = 80,
  Disarm = 40,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '回音击',
  Description = '',
  Range = {{1,-1},{1,0},{1,1},{0,1},{0,-1},{-1,-1},{-1,0},{-1,1}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 46.64,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 20,
     DeltaSuccess = 0.45,
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
  Name = '气吞山河',
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
    Stun = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 40,
     DeltaSuccess = 0,2,
     IsGoodBuff = false,
    },    
   },
  },
  EffectToC = {
   Type = 5,
   BaseNumber = 45, 
   DeltaNumber = 0.1,  
   Buffs = { 
        
   },
  },
  CD = 5,
 },
 LeaderSkill = {
  Name = '火之守卫',
  Description = '所有火系队员提升防御15%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   
Def = 15,










  },
 },
 CooperateSkill = {},
}

return NiuMoWang
