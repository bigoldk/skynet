local DongHaiLongNv = {
 Information = {
  Index = 29,
  Ename = 'DongHaiLongNv',
  Name = '东海龙女',
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
  BaseAtk = 92.8,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 5.1, 
  BaseDef = 15.1801419507439, 
  DeltaDef = 0.982582927330964, 
  BaseHp = 125.692387847557, 
  DeltaHp = 24.4690897164631, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 0,
  Poison = 5,
  Bleeding = 5,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '东海之歌',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1},{0,1},{0,-1}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 118,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Def = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = -15,
     DeltaNumber = -0.3,
     BaseSuccess = 50,
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
  Name = '沉鱼',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 17.538845142899, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Def = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -10,
     DeltaNumber = -0.3,
     BaseSuccess = 15,
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
  Name = '木之活力',
  Description = '所有木系队员提升生命15%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return DongHaiLongNv
