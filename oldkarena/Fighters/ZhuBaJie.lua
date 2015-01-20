local ZhuBaJie = {
 Information = {
  Index = 37,
  Ename = 'ZhuBaJie',
  Name = '猪八戒',
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
  BaseAtk = 101.913168673759,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 7.75057510542117, 
  BaseDef = 32.2, 
  DeltaDef = 2.20780931396783, 
  BaseHp = 427, 
  DeltaHp = 75.3333333333333, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 100,
  Freeze = 50,
  Disarm = 5,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '横扫千军',
  Description = '',
  Range = {{-1,2},{-1,1},{-1,0},{-1,-1},{-1,-2}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 70.56,
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
  Name = '刚烈无双',
  Description = '', 
  Range = {{0,0}}, 
  HitType = "ground", 
  Speed = 20, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 0, 
   BaseNumber = 0, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
        
   },
  },
  EffectToC = {
   Type = 1,
   BaseNumber = 0, 
   DeltaNumber = 0,  
   Buffs = { 
    	Def = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 30,
     DeltaNumber = 1.5,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = true,
    },    
   },
  },
  CD = 5,
 },
 LeaderSkill = {
  Name = '土之守卫',
  Description = '所有土系队员提升防御15%',
  EffectiveToType = {
   'Earth',
  },
  Effect = {
   
Def = 15,










  },
 },
 CooperateSkill = {},
}

return ZhuBaJie
