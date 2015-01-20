--
-- Author: HBS
-- Date: 2014-11-19 
--
local NO_01 = {
 Information = {
  Index = 1001,
  Name = '小山羊',
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
  DeltaAtk = 10, 
  BaseDef = 10, 
  DeltaDef = 2, 
  BaseHp = 150, 
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
  Name = '羊角挑',
  Description = '',
  Range = {{-1,0}},
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
 },
 LeaderSkill = {
 },
 CooperateSkill = {},
}

return NO_01
