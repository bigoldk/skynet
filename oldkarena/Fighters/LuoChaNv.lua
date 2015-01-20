local LuoChaNv = {
 Information = {
  Index = 13,
  Ename = 'LuoChaNv',
  Name = '罗刹女',
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
  BaseAtk = 164.599841044473,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 11.274023107787, 
  BaseDef = 20.3755699831873, 
  DeltaDef = 1.1966885145878, 
  BaseHp = 167.257894237939, 
  DeltaHp = 31.0135667464962, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 15,
  Freeze = 15,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 20,
 },
 NormalAtk = {
  Name = '青锋双剑',
  Description = '',
  Range = {{-1,1},{-1,-1}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 2,
  CriP = 0.05,
  CriV = 1.2,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 61.13,
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
  Name = '芭蕉扇',
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
   BaseNumber = 80, 
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
  CD = 3,
 },
 LeaderSkill = {
  Name = '铁扇清风',
  Description = '己方队员晕眩抗性增加50%',
  EffectiveToType = {
   'DPS','BUFF','TANK',
  },
  Effect = {
   





ResistStun = 50,





  },
 },
 CooperateSkill = {},
}

return LuoChaNv
