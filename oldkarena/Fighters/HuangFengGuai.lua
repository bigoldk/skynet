local HuangFengGuai = {
 Information = {
  Index = 11,
  Ename = 'HuangFengGuai',
  Name = '黄风怪',
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
  BaseAtk = 84.8,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 12.2546609190559, 
  BaseDef = 21.0403009895465, 
  DeltaDef = 1.17041691163136, 
  BaseHp = 170.4452231061, 
  DeltaHp = 31.7860195964284, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 30,
  Poison = 10,
  Bleeding = 10,
  CriticalDamage = 50,
 },
 NormalAtk = {
  Name = '黄沙飞舞',
  Description = '',
  Range = {{-1,0},{-1,1},{-1,-1},{-2,0},{-2,-1},{-2,1}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 2,
  CriP = 0.1,
  CriV = 6,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 33.3,
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
  Name = '三昧神风',
  Description = '', 
  Range = {{-2,0},{-2,1},{-2,-1},{-1,0},{-1,-1},{-1,1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.2, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 140.556921660718, 
   DeltaNumber = 0, 
   Special = {
    Displace = {
      Distance = {{1, 0}},
      PointRefX = "Receiver",
      PointRefY = "Receiver",
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '来去自如',
  Description = '己方队员定身抗性增加50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   






ResistFreeze = 50,




  },
 },
 CooperateSkill = {},
}

return HuangFengGuai
