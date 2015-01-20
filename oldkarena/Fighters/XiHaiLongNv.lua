local XiHaiLongNv = {
 Information = {
  Index = 32,
  Ename = 'XiHaiLongNv',
  Name = '西海龙女',
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
  BaseAtk = 112,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7, 
  BaseDef = 15.0802258300637, 
  DeltaDef = 0.976611485962408, 
  BaseHp = 126.18679158688, 
  DeltaHp = 23.2541816711566, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 5,
  Freeze = 5,
  Disarm = 0,
  Poison = 5,
  Bleeding = 0,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '西海之歌',
  Description = '',
  Range = {{-2,0},{-3,0},{-4,0}},
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
       	Poison = {
     BaseTime = 10,
     DeltaTime = 0,
     BaseNumber = -15,
     DeltaNumber = -0.75,
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
  Name = '羞花',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0}}, 
  HitType = "air", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 350.609091571441, 
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
  Name = '金之活力',
  Description = '所有金系队员提升生命15%',
  EffectiveToType = {
   'Metal',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return XiHaiLongNv
