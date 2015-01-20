local JiuLingYuanSheng = {
 Information = {
  Index = 38,
  Ename = 'JiuLingYuanSheng',
  Name = '九灵元圣',
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
  BaseAtk = 101.754443827009,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.99004268348801, 
  BaseDef = 33, 
  DeltaDef = 2.24152515590519, 
  BaseHp = 451.833333333333, 
  DeltaHp = 72, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 30,
  Freeze = 30,
  Disarm = 30,
  Poison = 30,
  Bleeding = 30,
  CriticalDamage = 60,
 },
 NormalAtk = {
  Name = '九灵护体',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 3,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 52.16,
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
  Name = '金刚不坏',
  Description = '', 
  Range = {{0,0}}, 
  HitType = "ground", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 0, 
   BaseNumber = 0, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
        
   },
  },
  EffectToC = {
   Type = 1,
   BaseNumber = 0, 
   DeltaNumber = 0,  
   Buffs = { 
    	Def = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 80,
     DeltaNumber = 4,
     BaseSuccess = 50,
     DeltaSuccess = 0,
     IsGoodBuff = true,
    },    
   },
  },
  CD = 5,
 },
 LeaderSkill = {
  Name = '木之守卫',
  Description = '所有木系队员提升防御15%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   
Def = 15,










  },
 },
 CooperateSkill = {},
}

return JiuLingYuanSheng
