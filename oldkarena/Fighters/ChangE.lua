local ChangE = {
 Information = {
  Index = 26,
  Ename = 'ChangE',
  Name = '嫦娥',
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
  BaseAtk = 125.2,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 8.2, 
  BaseDef = 15.4511627320359, 
  DeltaDef = 0.971836399744468, 
  BaseHp = 136.974966672243, 
  DeltaHp = 23.4650912677396, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 15,
  Freeze = 15,
  Disarm = 15,
  Poison = 15,
  Bleeding = 15,
  CriticalDamage = 15,
 },
 NormalAtk = {
  Name = '玉露琼浆',
  Description = '',
  Range = 'All',
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.2,
  CriV = 1.2,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -45,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	ContinuingHeal = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 60,
     DeltaNumber = 2.5,
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
  Name = '天外飞仙',
  Description = '', 
  Range = {{1,-1},{1,0},{1,1},{0,1},{0,-1},{-1,-1},{-1,0},{-1,1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = 0, 
   DeltaNumber = 0, 
   Special = '起死回生', 
   Buffs = { 
    Revive = {
     BaseTime = 0,
     DeltaTime = 0,
     BaseNumber = 50,
     DeltaNumber = 0,5,
     BaseSuccess = 50,
     DeltaSuccess = 0,5,
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
  Name = '广寒仙药',
  Description = '所有buff攻击提升20%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   Atk = 20,











  },
 },
 CooperateSkill = {},
}

return ChangE
