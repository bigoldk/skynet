local XiaoXiNiu = {
 Information = {
  Index = 44,
  Ename = 'XiaoXiNiu',
  Name = '小犀牛',
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
  BaseAtk = 94.1309392285322,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 6.86040302088919, 
  BaseDef = 30.05, 
  DeltaDef = 2.10112559077345, 
  BaseHp = 342.666666666667, 
  DeltaHp = 62.5333333333333, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 30,
  Bleeding = 50,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '冰霜铠甲',
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
   BaseNumber = 118.4,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
        Disarm = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 25,
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
 },
 SuperAtk = {
  Name = '开山斧',
  Description = '', 
  Range = {{-1,0}}, 
  HitType = "ground", 
  Speed = 100, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 460, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    Stun = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 100,
     DeltaSuccess = 0,
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
  CD = 8,
 },
 LeaderSkill = {
  Name = '以攻代守',
  Description = '所有tank攻击提升15%',
  EffectiveToType = {
   'TANK',
  },
  Effect = {
   Atk = 15,











  },
 },
 CooperateSkill = {},
}

return XiaoXiNiu
