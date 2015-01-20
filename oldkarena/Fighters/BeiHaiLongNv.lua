local BeiHaiLongNv = {
 Information = {
  Index = 31,
  Ename = 'BeiHaiLongNv',
  Name = '北海龙女',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'TANK',
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
  BaseAtk = 88.4,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 5.15, 
  BaseDef = 15.0226388718703, 
  DeltaDef = 0.989216225005258, 
  BaseHp = 127.110105595086, 
  DeltaHp = 24.6573310928915, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 0,
  Disarm = 5,
  Poison = 5,
  Bleeding = 0,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '北海之歌',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = -118,
   DeltaNumber = 0, 
   Special = 0, 
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
 },
 SuperAtk = {
  Name = '闭月',
  Description = '', 
  Range = {{0.1},{0.-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -25.990496500012, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 10,
     DeltaNumber = 0.3,
     BaseSuccess = 30,
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
  CD = 3,
 },
 LeaderSkill = {
  Name = '水之活力',
  Description = '所有水系队员提升生命15%',
  EffectiveToType = {
   'Water',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return BeiHaiLongNv
