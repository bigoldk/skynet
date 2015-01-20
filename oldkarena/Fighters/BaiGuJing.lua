local BaiGuJing = {
 Information = {
  Index = 16,
  Ename = 'BaiGuJing',
  Name = '白骨精',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
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
  BaseAtk = 121.758141108531,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.563745824293, 
  BaseDef = 21.2062877592086, 
  DeltaDef = 1.01765741859004, 
  BaseHp = 168.231652790511, 
  DeltaHp = 29.1776347568301, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 50,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '勾引',
  Description = '',
  Range = {{-1,0},{-2,0}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 4,
  CriP = 0.05,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 37.44,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	ResistStun = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },
ResistFreeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },
ResistDisarm = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },
	ResistPoison = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },
ResistBleeding = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },
	ResistCriticalDamage = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -8,
     DeltaNumber = -0.1,
     BaseSuccess = 80,
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
  Name = '魅惑',
  Description = '', 
  Range = {{-1,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 15, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    Chaos = {
     BaseTime = 3,
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
   Type = 5,
   BaseNumber = 25, 
   DeltaNumber = 0.1,  
   Buffs = { 
        
   },
  },
  CD = 4,
 },
 LeaderSkill = {
  Name = '枯骨逢春',
  Description = '所有buff攻击提升10%',
  EffectiveToType = {
   'BUFF',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return BaiGuJing
