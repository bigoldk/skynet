local DaPengJinChiNiao = {
 Information = {
  Index = 8,
  Ename = 'DaPengJinChiNiao',
  Name = '大鹏金翅鸟',
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
  BaseAtk = 164,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 13.5, 
  BaseDef = 25.5, 
  DeltaDef = 1, 
  BaseHp = 86.6666666666667, 
  DeltaHp = 22.9333333333333, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 20,
  Freeze = 20,
  Disarm = 20,
  Poison = 20,
  Bleeding = 20,
  CriticalDamage = 20,
 },
 NormalAtk = {
  Name = '腾云击',
  Description = '',
  Range = {{-1,0},{-1,1},{-1,-1},{-2,0},{-3,0}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 1,
  CriP = 0.2,
  CriV = 2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 60.44,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       Stun = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 35,
     DeltaSuccess = 0.3,
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
  Name = '鲲鹏万里',
  Description = '', 
  Range = {{-1,0},{-1,-1},{-1,-2},{-1,1},{-1,2},{-2,0},{-2,-1},{-2,1},{-3,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 196, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    Stun = {
     BaseTime = 1,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 85,
     DeltaSuccess = 0.15,
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
  CD = 8,
 },
 LeaderSkill = {
  Name = '金之统帅',
  Description = '所有金系队员攻击力提升10%',
  EffectiveToType = {
   'Metal',
  },
  Effect = {
   Atk = 10,











  },
 },
 CooperateSkill = {},
}

return DaPengJinChiNiao
