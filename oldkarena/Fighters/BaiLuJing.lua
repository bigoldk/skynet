local BaiLuJing = {
 Information = {
  Index = 34,
  Ename = 'BaiLuJing',
  Name = '白鹿精',
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
  BaseAtk = 101.6,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 6.3, 
  BaseDef = 14.6071862699735, 
  DeltaDef = 1.028715238715, 
  BaseHp = 118.347432015248, 
  DeltaHp = 24.3516531076091, 
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
  Name = '鹿灵',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}},
  HitType = "air",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  SpecialBoxEffectAtHitbox = true,
  EffectToR = {
   Type = 1,
   BaseNumber = 83.44,
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
  Name = '长生不死',
  Description = '', 
  Range = {{0,1},{0,-1}}, 
  HitType = "ground", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -264.990496500012, 
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
  CD = 3,
 },
 LeaderSkill = {
  Name = '土之活力',
  Description = '所有土系队员提升生命15%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return BaiLuJing
