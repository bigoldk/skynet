local XiongPiGuai = {
 Information = {
  Index = 43,
  Ename = 'XiongPiGuai',
  Name = '熊罴怪',
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
  BaseAtk = 95.4087737092533,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 6.80106933288608, 
  BaseDef = 30, 
  DeltaDef = 2.22322664471079, 
  BaseHp = 387, 
  DeltaHp = 66.6666666666667, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 20,
  Freeze = 40,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 30,
 },
 NormalAtk = {
  Name = '震撼大地',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1},},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 85,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -10,
     DeltaNumber = -0.7,
     BaseSuccess = 35,
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
 },
 SuperAtk = {
  Name = '怒意狂击',
  Description = '', 
  Range = {{-1,0}}, 
  HitType = "ground", 
  Speed = 100, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 3.5, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 381.637562335721, 
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
  Name = '战意',
  Description = '所有tank提升防御20%',
  EffectiveToType = {
   'TANK',
  },
  Effect = {
   
Def = 20,










  },
 },
 CooperateSkill = {},
}

return XiongPiGuai
