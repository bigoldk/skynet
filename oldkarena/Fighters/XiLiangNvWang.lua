local XiLiangNvWang = {
 Information = {
  Index = 28,
  Ename = 'XiLiangNvWang',
  Name = '西梁女王',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
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
  BaseAtk = 122,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 8.08, 
  BaseDef = 15.4082415395601, 
  DeltaDef = 1.01509679559086, 
  BaseHp = 132.395051444941, 
  DeltaHp = 24.756799304196, 
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
  Name = '女儿情',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -132,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	CriP = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 5,
     DeltaNumber = 0.25,
     BaseSuccess = 50,
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
 },
 SuperAtk = {
  Name = '女儿泪',
  Description = '', 
  Range = {{-1,0}}, 
  HitType = "ground", 
  Speed = 80, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -321.42314085715, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    Remove = {
     BaseTime = 0,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
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
  CD = 4,
 },
 LeaderSkill = {
  Name = '一误终身',
  Description = '所有buff定身、晕眩、封咒抗性增加50%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   





ResistStun = 50,
ResistFreeze = 50,
ResistDisarm = 50,



  },
 },
 CooperateSkill = {},
}

return XiLiangNvWang
