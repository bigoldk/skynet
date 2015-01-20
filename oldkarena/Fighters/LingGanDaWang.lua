local LingGanDaWang = {
 Information = {
  Index = 17,
  Ename = 'LingGanDaWang',
  Name = '灵感大王',
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
  BaseAtk = 140.396769626718,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.4517869449072, 
  BaseDef = 20.6601435799909, 
  DeltaDef = 1.05096194712512, 
  BaseHp = 162.408179958424, 
  DeltaHp = 29.0715625298316, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 15,
  Freeze = 15,
  Disarm = 15,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '雷击',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 86.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 45,
     DeltaSuccess = 0.05,
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
  Name = '鱼翔浅底',
  Description = '', 
  Range = {{-1,0},{-2,0},{-2,1},{-2,-1},{-3,0},{-3,1},{-3,-1},{-4,0},{-4,1},{-4,-1},{-5,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 157.058535268931, 
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
  Name = '水之将领',
  Description = '所有水系攻防提升5%',
  EffectiveToType = {
   'Water',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return LingGanDaWang
