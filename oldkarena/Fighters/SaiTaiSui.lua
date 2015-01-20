local SaiTaiSui = {
 Information = {
  Index = 4,
  Ename = 'SaiTaiSui',
  Name = '赛太岁',
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
  BaseAtk = 184,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.7, 
  BaseDef = 19.5, 
  DeltaDef = 1.3, 
  BaseHp = 168.333333333333, 
  DeltaHp = 39.2, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 20,
  Freeze = 20,
  Disarm = 20,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '紫金铃铛',
  Description = '',
  Range = {{-3,0},{-3,-1},{-3,1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.25,
  CriV = 2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 84.36,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 20,
     DeltaSuccess = 0.16,
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
  Name = '飞沙走石',
  Description = '', 
  Range = {{-1,0},{-2,0},{1,0},{2,0},{-1,-1},{-2,-1},{0,-1},{1,-1},{2,-1},{-1,-2},{0,-2},{1,-2},{-1,1},{-2,1},{0,1},{1,1},{2,1},{-1,2},{0,2},{1,2},}, 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 202.76895966004, 
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
  CD = 10,
 },
 LeaderSkill = {
  Name = '土之统帅',
  Description = '所有土系队员攻击力提升10%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return SaiTaiSui
