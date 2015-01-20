local BaiXiangWang = {
 Information = {
  Index = 42,
  Ename = 'BaiXiangWang',
  Name = '白象王',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'TANK',
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
  BaseAtk = 97.9112500101197,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.64469860844669, 
  BaseDef = 31.1, 
  DeltaDef = 2.12064617521147, 
  BaseHp = 366.333333333333, 
  DeltaHp = 64.2666666666667, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 5,
  Bleeding = 5,
  CriticalDamage = 100,
 },
 NormalAtk = {
  Name = '铁背铜身',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 118.4,
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
    DamageRebound = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 15,
     DeltaNumber = 0,1,
     BaseSuccess = 20,
     DeltaSuccess = 0,
     IsGoodBuff = true,
    },    
   },
  },
 },
 SuperAtk = {
  Name = '冰河世纪',
  Description = '', 
  Range = {{-1,0},{-2,0},{-3,0},{-1,1},{-2,1},{-3,1},{-1,-1},{-2,-1},{-3,-1}}, 
  HitType = "ground", 
  Speed = 100, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1, 
   BaseNumber = 148.740793525717, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Freeze = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 0,
     DeltaNumber = 0,
     BaseSuccess = 20,
     DeltaSuccess = 0.05,
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
  CD = 5,
 },
 LeaderSkill = {
  Name = '金之守卫',
  Description = '所有金系队员提升防御15%',
  EffectiveToType = {
   'Metal',
  },
  Effect = {
   
Def = 15,










  },
 },
 CooperateSkill = {},
}

return BaiXiangWang
