local HuLiJing = {
 Information = {
  Index = 35,
  Ename = 'HuLiJing',
  Name = '狐狸精',
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
  BaseAtk = 83.6,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 4.3, 
  BaseDef = 14.6022985510314, 
  DeltaDef = 1.01567147369443, 
  BaseHp = 124.96182040127, 
  DeltaHp = 24.2868132417696, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '如花解语',
  Description = '',
  Range = {{-2,1},{-2,0},{-2,-1}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 44.8,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Atk = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -30,
     DeltaNumber = -1,
     BaseSuccess = 50,
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
  Name = '似玉生香',
  Description = '', 
  Range = {{-2,0},{-3,0},{-4,0},{-2,1},{-3,1},{-4,1},{-2,-1},{-3,-1},{-4,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = 11.688801764288, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Atk = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -20,
     DeltaNumber = -0.5,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '鼓舞',
  Description = '所有dps暴伤提升100%',
  EffectiveToType = {
   'DPS',
  },
  Effect = {
   



CriV = 100,







  },
 },
 CooperateSkill = {},
}

return HuLiJing
