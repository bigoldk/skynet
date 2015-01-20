local YangLi = {
 Information = {
  Index = 21,
  Ename = 'YangLi',
  Name = '羊力',
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
  BaseAtk = 136.612925212249,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 11.9176549459475, 
  BaseDef = 21.2870202593801, 
  DeltaDef = 1.10903685572508, 
  BaseHp = 154.279296049159, 
  DeltaHp = 29.1885342023034, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 10,
  Disarm = 0,
  Poison = 10,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '羊之力',
  Description = '',
  Range = {{-3,0},{-4,0},{-4,1},{-4,-1},{-5,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 65.96,
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
  Name = '冷龙护体',
  Description = '', 
  Range = 'Rand3',
  -- Range = {{1,1}},  
  HitType = "ground", 
  Speed = 80, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -15.3, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 12,
     DeltaNumber = 0.4,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '水之先锋',
  Description = '所有水系暴击率miss率提升5%',
  EffectiveToType = {
   'Water',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return YangLi
