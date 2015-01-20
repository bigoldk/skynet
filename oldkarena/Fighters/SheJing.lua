local SheJing = {
 Information = {
  Index = 19,
  Ename = 'SheJing',
  Name = '蛇精',
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
  BaseAtk = 156.283624972906,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 11.7604812999289, 
  BaseDef = 20.7101644221199, 
  DeltaDef = 1.08996854222972, 
  BaseHp = 163.482027420842, 
  DeltaHp = 29.7485293610364, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 20,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '吸血',
  Description = '',
  Range = {{-1,0},{-2,0}},
  HitType = "ground",
  Speed = 60,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1,
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
   Type = 5, 
   BaseNumber = 5, 
   DeltaNumber = 0.05, 
   Buffs = { 
        
   },
  },
 },
 SuperAtk = {
  Name = '死亡缠绕',
  Description = '', 
  Range = {{-2,0}}, 
  HitType = "ground", 
  Speed = 40, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 381.637562335721, 
   DeltaNumber = 0, 
   Special = 秒杀, 
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '金之先锋',
  Description = '所有金系暴击率miss率提升5%',
  EffectiveToType = {
   'Metal',
  },
  Effect = {
   


CriP = 5,

Miss = 5,






  },
 },
 CooperateSkill = {},
}

return SheJing
