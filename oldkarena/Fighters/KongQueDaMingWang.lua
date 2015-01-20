local KongQueDaMingWang = {
 Information = {
  Index = 9,
  Ename = 'KongQueDaMingWang',
  Name = '孔雀大明王',
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
  BaseAtk = 100,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 17, 
  BaseDef = 20.6647327564639, 
  DeltaDef = 1.2, 
  BaseHp = 97.3333333333333, 
  DeltaHp = 20, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 20,
  Freeze = 20,
  Disarm = 20,
  Poison = 20,
  Bleeding = 20,
  CriticalDamage = 20,
 },
 NormalAtk = {
  Name = '孔雀开屏',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.2,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 41.12,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -25,
     DeltaNumber = 0,
     BaseSuccess = 75,
     DeltaSuccess = 0.2,
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
  Name = '孔雀明舞',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.25, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 65, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    HitRate = {
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
  CD = 3,
 },
 LeaderSkill = {
  Name = '孔雀之歌',
  Description = '所有buff血量提升15%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return KongQueDaMingWang
