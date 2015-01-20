local SunWuKong = {
 Information = {
  Index = 5,
  Ename = 'SunWuKong',
  Name = '孙悟空',
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
  BaseAtk = 60,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 19.2, 
  BaseDef = 9, 
  DeltaDef = 1.1, 
  BaseHp = 129, 
  DeltaHp = 48, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 40,
  Freeze = 40,
  Disarm = 60,
  Poison = 20,
  Bleeding = 20,
  CriticalDamage = 20,
 },
 NormalAtk = {
  Name = '力压千钧',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.5,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 63.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 5,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 5,
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
  Name = '大杀四方',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0},{-1,-1},{-2,-1},{-3,-1},{-4,-1},{-5,-1},{-1,-2},{-2,-2},{-3,-2},{-4,-2},{-5,-2},{-1,1},{-2,1},{-3,1},{-4,1},{-5,1},{-1,2},{-2,2},{-3,2},{-4,2},{-5,2}}, 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.5, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 132.105310039288, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Def = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = -50,
     DeltaNumber = -1,
     BaseSuccess = 25,
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
  Name = '大闹天宫',
  Description = '己方队员增加10%防御',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   
Def = 10,










  },
 },
 CooperateSkill = {},
}

return SunWuKong
