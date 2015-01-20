local HuangMeiGuai = {
 Information = {
  Index = 3,
  Ename = 'HuangMeiGuai',
  Name = '黄眉怪',
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
  BaseAtk = 177.2,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.2, 
  BaseDef = 22, 
  DeltaDef = 1.3, 
  BaseHp = 188.5, 
  DeltaHp = 36.6666666666667, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 5,
  Poison = 5,
  Bleeding = 5,
  CriticalDamage = 60,
 },
 NormalAtk = {
  Name = '杀狼驱虎',
  Description = '',
  Range = {{-1,-1},{-1,1},{-2,-2},{-2.2}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 2,
  CriP = 0,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 49.998,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Atk = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = -25,
     DeltaNumber = -0.8,
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
  Name = '泣鬼惊神',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0},{-1,-1},{-2,-1},{-3,-1},{-4,-1},{-5,-1},{-1,-2},{-2,-2},{-3,-2},{-4,-2},{-5,-2},{-1,1},{-2,1},{-3,1},{-4,1},{-5,1},{-1,2},{-2,2},{-3,2},{-4,2},{-5,2}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 102.210620078576, 
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
  Name = '木之统帅',
  Description = '所有木系队员攻击力提升10%',
  EffectiveToType = {
   'Wood',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return HuangMeiGuai
