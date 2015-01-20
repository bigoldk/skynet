local NanHaiLongNv = {
 Information = {
  Index = 30,
  Ename = 'NanHaiLongNv',
  Name = '南海龙女',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
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
  BaseAtk = 91.6,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 5.2, 
  BaseDef = 14.87468666791, 
  DeltaDef = 0.981729926831323, 
  BaseHp = 125.604194976754, 
  DeltaHp = 22.7994179696, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 5,
  Disarm = 5,
  Poison = 5,
  Bleeding = 0,
  CriticalDamage = 5,
 },
 NormalAtk = {
  Name = '南海之歌',
  Description = '',
  Range = {{-1,1},{-1,0},{-1,-1}},
  HitType = "ground",
  Speed = 100,
  HitPerBox = 1,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -120,
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
  Name = '落雁',
  Description = '', 
  Range = {{2,0},{-2,0},{0,-2},{0,2},{1,0},{0,1},{0,-1},{-1,0},{1,1},{1,-1},{-1,1},{-1,-1}}, 
  HitType = "ground", 
  Speed = 0, 
  HitPerBox = 1, 
  CriP = 0.05, 
  CriV = 1.2, 
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1, 
   BaseNumber = -138.804545785721, 
   DeltaNumber = 0, 
   Special = 0, 
   Buffs = { 
    	Atk = {
     BaseTime = 2,
     DeltaTime = 0,
     BaseNumber = 50,
     DeltaNumber = 2,
     BaseSuccess = 30,
     DeltaSuccess = 0,
     IsGoodBuff = true,
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
  Name = '火之火力',
  Description = '所有火系队员提升生命15%',
  EffectiveToType = {
   'Fire',
  },
  Effect = {
   

Hp = 15,









  },
 },
 CooperateSkill = {},
}

return NanHaiLongNv
