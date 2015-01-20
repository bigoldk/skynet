local LuLi = {
 Information = {
  Index = 22,
  Ename = 'LuLi',
  Name = '鹿力',
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
  BaseAtk = 76.5129422699707,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.3, 
  BaseDef = 20.1063284901254, 
  DeltaDef = 1.04804265132879, 
  BaseHp = 168.210104094063, 
  DeltaHp = 30.1019573289433, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 10,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 10,
 },
 NormalAtk = {
  Name = '鹿之力',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 4,
  CriP = 0.05,
  CriV = 8,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 33.024,
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
  Name = '静坐高台',
  Description = '', 
  Range = {{0,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 0, 
   BaseNumber = 0, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
        
   },
  },
  EffectToC = {
   Type = 1,
   BaseNumber = 0, 
   DeltaNumber = 0,  
   Buffs = { 
    	Atk = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 60,
     DeltaNumber = 2,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = true,
    },    
   },
  },
  CD = 5,
 },
 LeaderSkill = {
  Name = '火之先锋',
  Description = '所有火系暴击率miss率提升5%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return LuLi
