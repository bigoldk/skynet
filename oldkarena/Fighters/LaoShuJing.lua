local LaoShuJing = {
 Information = {
  Index = 18,
  Ename = 'LaoShuJing',
  Name = '老鼠精',
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
  BaseAtk = 124.576223626926,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.0483718811341, 
  BaseDef = 20.2442783989324, 
  DeltaDef = 1.06911806635285, 
  BaseHp = 156.566607595311, 
  DeltaHp = 30.7538719272844, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 20,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '鼠槌',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}},
  HitType = "air",
  Speed = 20,
  HitPerBox = 2,
  CriP = 0.05,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 63.66,
   DeltaNumber = 0, 
   Special = { 
   Displace = {
      "ScriptDeal"
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
 },
 SuperAtk = {
  Name = '清风',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0}}, 
  HitType = "ground", 
  Speed = 80, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 243.008533282147, 
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '金之将领',
  Description = '所有金系攻防提升5%',
  EffectiveToType = {
   'Metal',
  },
  Effect = {
   Atk = 5,
Def = 5,










  },
 },
 CooperateSkill = {},
}

return LaoShuJing
