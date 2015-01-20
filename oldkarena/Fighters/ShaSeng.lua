local ShaSeng = {
 Information = {
  Index = 6,
  Ename = 'ShaSeng',
  Name = '沙僧',
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
  BaseAtk = 248,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10, 
  BaseDef = 30.5, 
  DeltaDef = 0.9, 
  BaseHp = 266.666666666667, 
  DeltaHp = 29.5, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 30,
  Freeze = 15,
  Disarm = 15,
  Poison = 10,
  Bleeding = 10,
  CriticalDamage = 10,
 },
 NormalAtk = {
  Name = '魂飞魄散',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1},{-2,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.2,
  CriV = 2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 72.4,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Disarm = {
     BaseTime = 4,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 15,
     DeltaSuccess = 0.6,
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
  Name = '流沙滚滚',
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
   BaseNumber = 114.877890620359, 
   DeltaNumber = 0, 
   Special = {
     KnockOut = {
      BaseSuccess = {100,5,6.5,8,9},
      DeltaSuccess = 0.05,
      DealDemage = true,
     }, 
   }, 
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
  CD = 0,
 },
 LeaderSkill = {
  Name = '水之统帅',
  Description = '所有水系队员攻击力提升10%',
  EffectiveToType = {
   'Water',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return ShaSeng
