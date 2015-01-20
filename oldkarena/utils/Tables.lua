local Tables = {}
Tables.FighterBuffTargets = {
	Hp = "buffAddon", Atk="buffAddon", Def="buffAddon", CriP="buffAddon", CriV="buffAddon", MoveAbility="buffAddon", -- basic ability 
	ResistStun="buffAddon", ResistFreeze="buffAddon", ResistDisarm="buffAddon", ResistPoison="buffAddon", ResistBleeding="buffAddon", ResistCriticalDamage="buffAddon", -- resistance
	Stun="buffsInBattle", Freeze="buffsInBattle", Disarm="buffsInBattle", Poison="buffsInBattle", Bleeding="buffsInBattle", -- debuffs
	ContinuingHeal="buffsInBattle", ActTwice="buffsInBattle", CounterAttack="buffsInBattle", Immune="buffsInBattle", Invincible="buffsInBattle", -- buffs
}
Tables.FighterAtkContent = {
	"Name", "Description", "Target", "Range", "HitType", "Speed",
	"HitPerBox", "CriP", "CriV", "EffectToR", "EffectToC", "CD",
}
Tables.FighterAtkEffectContent = {
	"Type", "BaseNumber", "DeltaNumber", "Special", "Buffs",
}
Tables.FighterResistanceTypes = {
	"Stun", "Freeze", "Disarm", "Poison", "Bleeding", "CriticalDamage",
}
Tables.FighterAbilityContent = {
	"BaseAtk", "DeltaAtk", "BaseDef", "DeltaDef", "BaseHp", "DeltaHp", 
	"MoveFriend", "MoveEnemy", "MovePreference",
}
Tables.FighterLeaderSkillEffectiveToTypes = {
	"Metal", "Wood", "Water", "Fire", "Earth", "DPS", "TANK", "BUFF",
}
Tables.FighterLeaderSkillEffect = {
	"Atk", "Def", "Hp", "CriP", "CriV", 
	"ResistStun", "ResistFreeze", "ResistDisarm", "ResistPoison", "ResistBleeding", "ResistCriticalDamage",
}
Tables.FighterScripts = {
	"ShengYingDaWang","LuoChaNv","LaoShuJing","JinJiao","BaiLuJing"
}
Tables.FighterNameList = {
	["1"] = "SunWuKong",
	["2"] = "ShengYingDaWang",
	["3"] = "ShaSeng",
	["4"] = "SaiTaiSui",
	["5"] = "LiuErMiHou",
	["6"] = "KongQueDaMingWang",
	["7"] = "HuangMeiGuai",
	["8"] = "DaPengJinChiNiao",
	["9"] = "BaiLongMa",
}

Tables.BaseValues = {
	"Hp", "Atk", "Def"
}

Tables.Gifts = {
	"Gold", "Wood", "Water", "Fire", "Earth",
}

Tables.GiftInformation = {
	--Hp, Atk, Def, Miss, CriP, CriV, Resists
	Gold = {
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},}, --各层天赋二选一
			{{Def = 10,Hp = 12},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			}, --各系天赋
	Fire = {
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Def = 10,Hp = 12},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			},
	Wood = {
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Def = 10,Hp = 12},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			},
	Earth = {
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Def = 10,Hp = 12},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			},
	Water = {
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Def = 10,Hp = 12},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			{{Atk = 15,CriP = 0.04},{Atk = 10, CriP = 0.08},},
			},
}
return Tables