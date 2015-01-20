local YuTuJing = {
 Information = {
  Index = 33,
  Ename = 'YuTuJing',
  Name = '玉兔精',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
  Sex = "Female",
 },
CookSkill = {
  type = "baoji",
  prob = 50,
  food = {"daomi","zhurou"}
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
  BaseAtk = 103.2,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 6.2, 
  BaseDef = 14.758273034831, 
  DeltaDef = 0.997698340049517, 
  BaseHp = 122.634400780088, 
  DeltaHp = 24.1462581675216, 
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
  Name = '捣药',
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
   BaseNumber = -82,
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
  Name = '玉兔舞',
  Description = '', 
  Range = {{-1,1},{-1,0},{-1,-1}}, 
  HitType = "ground", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -287.043636628577, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	ContinuingHeal = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 80,
     DeltaNumber = 2,
     BaseSuccess = 75,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '捣药疗伤',
  Description = '己方队员流血抗性提升50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   









ResistBleeding = 50,

  },
 },
 CooperateSkill = {},
}

return YuTuJing
