--
-- Author: HBS
-- Date: 2014-11-19 
--
local NO_01 = {
 Information = {
  Index = 1001,
  Name = '头狼',
  Description = '',
  Cost = 25,
  MaxStar = 5,
  Profession = 'DPS',
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
  BaseAtk = 50,
  BaseMiss = 5,
  DeltaMiss = 0,
  DeltaAtk = 30, 
  BaseDef = 10, 
  DeltaDef = 2, 
  BaseHp = 250, 
  DeltaHp = 50, 
  MoveFriend = 9999,
  MoveEnemy = 1, 
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
  Name = '狼爪',
  Description = '',
  Range = {{-1,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 50,
  CriV = 1.4,
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
  Name = '狼嚎',
  Description = '',
  Range = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0},{-6,0}},
  HitType = "ground",
  Speed = 20,
  HitPerBox = 1,
  CriP = 50,
  CriV = 1.4,
  ReceiverIsFriend = false,
  EffectToR = {
   Type = 1,
   BaseNumber = 5,
   DeltaNumber = 1, 
   Special = 0, 
   Buffs = {    
   },
  },
  EffectToC = {
   Type = 0, 
   BaseNumber = 0, 
   DeltaNumber = 0, 
   Buffs = {
    Def = {
     BaseTime = 3,
     DeltaTime = 0,
     BaseNumber = 20,
     DeltaNumber = 1,
     BaseSuccess = 100,
     DeltaSuccess = 0,
     IsGoodBuff = false,
    },   
   },
  },
  CD = 2,
 },

 LeaderSkill = {
 },
 CooperateSkill = {},
}

return NO_01
