local ShengYingDaWang = {
 Information = {
  Index = 1,
  Ename = 'ShengYingDaWang',
  Name = '圣婴大王',
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
  BaseAtk = 140,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 15, 
  BaseDef = 16.5, 
  DeltaDef = 1.4, 
  BaseHp = 218.6666667, 
  DeltaHp = 37.6, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 10,
  Freeze = 50,
  Disarm = 15,
  Poison = 5,
  Bleeding = 10,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '火焰枪',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0}},
  -- Range = "Rand1",
  HitType = "ground",
  Speed = 40,
  HitPerBox = 3,
  CriP = 0.25,
  CriV = 2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 39.28,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
     Bleeding = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = -50,
     DeltaNumber = -1.5,
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
  Name = '三昧真火',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-2,-1},{-2,1},{-4,0}},
  SpecialBoxEffect = 6,
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 154.737566309289, 
   DeltaNumber = 0, 
   Special = {
    -- ExtraEffect = {
    --   Type = 1,
    --   BaseNumber = 300,
    --   DeltaNumber = 0,
    --   Range = {-4,0},
    --   RefX = "Self",
    --   RefY = "Self",
    -- }
   }, 
   Buffs = { 
      Bleeding = {
     BaseTime = 5,
     DeltaTime = 0,
     BaseNumber = -100,
     DeltaNumber = -4,
     BaseSuccess = 10,
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
  Name = '火之统帅',
  Description = '所有火系队员攻击力提升10%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return ShengYingDaWang
