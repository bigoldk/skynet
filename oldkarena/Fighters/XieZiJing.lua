local XieZiJing = {
 Information = {
  Index = 10,
  Ename = 'XieZiJing',
  Name = '蝎子精',
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
  BaseAtk = 114,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10.5772669475857, 
  BaseDef = 20.1361432770754, 
  DeltaDef = 1.12532086734313, 
  BaseHp = 171.904061613395, 
  DeltaHp = 32.6476602509808, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 100,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '倒马毒桩',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1}},
  HitType = "ground",
  Speed = 40,
  HitPerBox = 2,
  CriP = 0,
  CriV = 1,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 52.528,
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = {
       	Poison = {
     BaseTime = 5,
     DeltaTime = 0,
     BaseNumber = -40,
     DeltaNumber = -1.2,
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
  Name = '反弹琵琶',
  Description = '', 
  Range = {{-1,1},{-1,0},{-1,-1}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 292.914983741434, 
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
  Name = '百毒不侵',
  Description = '己方队员毒抗性增加50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   








ResistPoison = 50,


  },
 },
 CooperateSkill = {},
}

return XieZiJing
