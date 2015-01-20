--
-- Author: HBS
-- Date: 2014-11-19 
--
local NO_01 = {
 Information = {
  Index = 1001,
  Name = '小兔子',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'BUFF',
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
  BaseAtk = 20,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 10, 
  BaseDef = 5, 
  DeltaDef = 1, 
  BaseHp = 150, 
  DeltaHp = 30, 
  MoveFriend = 9999,
  MoveEnemy = 2, 
  MovePreference = 0, 
 },
 Resistance = {
  Stun = 0,
  Freeze = 0,
  Disarm = 0,
  Poison = 0,
  Bleeding = 0,
  CriticalDamage = 0,
 },
 NormalAtk = {
  Name = '撞击',
  Description = '',
  Range = {{-2,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0,
  CriV = 0,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 100,
   DeltaNumber = 5, 
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
  Name = '兔子舞',
  Description = '',
  Range = {{0,0},{-1,0},{-2,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 0,
  CriV = 0,
  ReceiverIsFriend = true,
  EffectToR = {
   Type = 1,
   BaseNumber = -150,
   DeltaNumber = -10, 
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
  CD = 1,
 },
 LeaderSkill = {
 },
 CooperateSkill = {},
}

return NO_01
