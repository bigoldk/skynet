local YinJiao = {
 Information = {
  Index = 12,
  Ename = 'YinJiao',
  Name = '银角',
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
  BaseAtk = 156.8,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 11.688316401531, 
  BaseDef = 21.2945833213044, 
  DeltaDef = 1.13832792658106, 
  BaseHp = 168.347469662857, 
  DeltaHp = 31.9308712069411, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 100,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '移山倒海',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 60,
  HitPerBox = 1,
  CriP = 0.1,
  CriV = 1.5,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 86.2,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Freeze = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 50,
     DeltaSuccess = 0.1,
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
  Name = '紫金葫芦',
  Description = '', 
  Range = {{-1,0}}, 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 0.000000000001, 
   DeltaNumber = 0, 
   Special = 
     {
     KnockOut = {
     BaseSuccess = {30,35,42,50,60},
     DeltaSuccess = 0.2,
     DealDemage = false
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
  CD = 4,
 },
 LeaderSkill = {
  Name = '坚如磐石',
  Description = '己方队员暴击抗性增加50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   










ResistCriticalDamage = 50,
  },
 },
 CooperateSkill = {},
}

return YinJiao
