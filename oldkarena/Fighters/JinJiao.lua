local JinJiao = {
 Information = {
  Index = 39,
  Ename = 'JinJiao',
  Name = '金角',
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
  BaseAtk = 97.3560995464826,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.00647792523496, 
  BaseDef = 31, 
  DeltaDef = 2.20897798433093, 
  BaseHp = 370.333333333333, 
  DeltaHp = 63.7333333333333, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 100,
  Freeze = 0,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '金绳缚',
  Description = '',
  Range = {{-1,0},{-2,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 100,
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
  Name = '羊脂玉净',
  Description = '', 
  Range = {{-1,1},{-1,-1},{-2,1},{-2,-1},{-3,1},{-3,-1},{-4,1},{-4,-1},}, 
  HitType = "ground", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 1.888017642878, 
   DeltaNumber = 0, 
   Special = {
        Displace = {
          Distance = {{0, 0}},
          PointRefX = "Receiver",
          PointRefY = "Self",
        },
      },
   Buffs = { 
    Stun = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
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
  CD = 0,
 },
 LeaderSkill = {
  Name = '通筋活脉',
  Description = '己方队员封咒抗性提升50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   







ResistDisarm = 50,



  },
 },
 CooperateSkill = {},
}

return JinJiao
