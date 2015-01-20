local QingMaoShi = {
 Information = {
  Index = 40,
  Ename = 'QingMaoShi',
  Name = '青毛狮',
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
  BaseAtk = 97.1530045774012,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 6.62274224425051, 
  BaseDef = 30.95, 
  DeltaDef = 2.29981812251818, 
  BaseHp = 425.5, 
  DeltaHp = 68, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 15,
  Freeze = 15,
  Disarm = 15,
  Poison = 10,
  Bleeding = 10,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '狮子吼',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 72.4,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -25,
     DeltaNumber = -0.1,
     BaseSuccess = 20,
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
 },
 SuperAtk = {
  Name = '兽血沸腾',
  Description = '', 
  Range = {{0,0}}, 
  HitType = "ground", 
  Speed = 100, 
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
    Hp = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 500,
     DeltaNumber = 15,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = true,
    },    
   },
  },
  CD = 6,
 },
 LeaderSkill = {
  Name = '外物不侵',
  Description = '己方所有队员抗性提升5%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   





ResistStun = 5,
ResistFreeze = 5,
ResistDisarm = 5,
ResistPoison = 5,
ResistBleeding = 5,
ResistCriticalDamage = 5,
  },
 },
 CooperateSkill = {},
}

return QingMaoShi
