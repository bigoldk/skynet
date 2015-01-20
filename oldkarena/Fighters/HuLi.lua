local HuLi = {
 Information = {
  Index = 20,
  Ename = 'HuLi',
  Name = '虎力',
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
  BaseAtk = 80.8115221192599,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 8.2, 
  BaseDef = 20.7719126045447, 
  DeltaDef = 1.18483507537632, 
  BaseHp = 154.531667369235, 
  DeltaHp = 30.0561414517194, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 10,
  Freeze = 0,
  Disarm = 0,
  Poison = 0,
  Bleeding = 10,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '虎之力',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 5,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 88.96,
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
 },
 SuperAtk = {
  Name = '呼风唤雨',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 3, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 68.746105949146, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -12,
     DeltaNumber = -0.2,
     BaseSuccess = 22,
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
  Name = '木之先锋',
  Description = '所有木系暴击率miss率提升5%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return HuLi
