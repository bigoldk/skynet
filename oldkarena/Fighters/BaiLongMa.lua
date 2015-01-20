local BaiLongMa = {
 Information = {
  Index = 7,
  Ename = 'BaiLongMa',
  Name = '白龙马',
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
  BaseAtk = 204.8,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 11.7, 
  BaseDef = 22.5, 
  DeltaDef = 1.2, 
  BaseHp = 200, 
  DeltaHp = 34.6666666666667, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 10,
  Poison = 5,
  Bleeding = 10,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '白龙出水',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-2,-1},{-2,1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.2,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 61.36,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -20,
     DeltaNumber = -0.2,
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
 },
 SuperAtk = {
  Name = '真龙烈焰',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-2,-1},{-2,1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 209.737566309289, 
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
  Name = '龙族之魂',
  Description = '所有dps暴击率提升10%',
  EffectiveToType = {
   'DPS',
  },
  Effect = {
   


CriP = 10,








  },
 },
 CooperateSkill = {},
}

return BaiLongMa
