--
-- Author: Yiran WANG
-- Date: 2014-08-22 16:11:22
--
local Functions = require "Functions"
local Macros = require "Macros"

local Formulas = {}

function Formulas.getBaseAtkOfFighter(fighterability, star, level)
	return Functions.getInteger((fighterability.BaseAtk + fighterability.DeltaAtk * level)*Macros.STARCOEFFCIENT^(star - 1))
end

function Formulas.getBaseDefOfFighter(fighterability, star, level)
	return Functions.getInteger((fighterability.BaseDef + fighterability.DeltaDef * level)*Macros.STARCOEFFCIENT^(star - 1))
end

function Formulas.getBaseHpOfFighter(fighterability, star, level)
	return Functions.getInteger((fighterability.BaseHp + fighterability.DeltaHp * level)*Macros.STARCOEFFCIENT^(star - 1))
end

function Formulas.getBaseMissOfFighter(fighterability, star, level)
	return fighterability.BaseMiss + fighterability.DeltaMiss * level
end

--params:base,captain,buff,equipment,gift,level,star,gifttype

function Formulas.getHp(params)
	return Functions.getInteger((params.equipment.Hp + params.base.Hp + params.buff.Hp) * (100 + params.fever.Hp + params.captain.Hp + params.gift.Hp) / 100)
end

function Formulas.convertRatingToPercentage(rating, level, star, attrtoconvert)
     if attrtoconvert == "Resists" then
     	return rating / ((level^2 + level + 10)*100)
     else
     	local vRet = rating / (level^2/100 + level/2 + 1)
     	if attrtoconvert == "Miss" then
     		vRet = vRet * 4
     	elseif attrtoconvert == "CriP" then
     		vRet = vRet * 2
     	elseif attrtoconvert ~= "CriV" then
     		assert(nil, "attribute input wrong")
     	end
     	return vRet
     end
end

function Formulas.getBaseValue (params, key )
	 return params.base[key] + params.equipment[key] + params.buff[key]
end

function Formulas.getRatioValue (params, key )
	return (params.captain[key] + params.gift[key] + params.fever[key]) / 100
end

function Formulas.getValueToCaster(skillToCast, params)
		--计算过程
	local attackOfCaster = Formulas.getBaseValue(params, "Atk")
	local defenceOfCaster =  Formulas.getBaseValue(params, "Def")
	local attackRatioOfCaster = Formulas.getRatioValue(params, "Atk")
	local defenceRatioOfCaster = Formulas.getRatioValue(params, "Def")
	local CriV = (skillToCast.CriV + params.base.CriV + params.fever.CriV + params.gift.CriV + params.captain.CriV + Formulas.convertRatingToPercentage(params.buff.CriV + params.equipment.CriVRating, params.level, params.star, "CriV"))
	local CriP = (skillToCast.CriP + params.base.CriP + params.fever.CriV + params.gift.CriP + params.captain.CriP + Formulas.convertRatingToPercentage(params.buff.CriV + params.equipment.CriPRating, params.level, params.star, "CriP"))
	local critical = false
	print(skillToCast.Name)
	local ratio = skillToCast.EffectToC.BaseNumber + params.level * skillToCast.EffectToC.DeltaNumber
	local RealValueToCaster = 0
	if skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeAttackRelated then 
		if CriP > Functions.RandomBetweenLowAndUp(0,1) then 
			if ratio < 0 then 
				ratio = CriV * ratio
				critical = true
			end		
		end
		if ratio > 0 then 
			RealValueToCaster = (attackOfCaster * ratio / 100 - defenceOfCaster) * math.max(0, (1 + attackRatioOfCaster))/math.max(0, (1 + defenceRatioOfCaster))
			if RealValueToCaster <= 1 then 
				RealValueToCaster = 1 
			end
		else 
			RealValueToCaster = attackOfCaster * ratio / 100 * (1 + attackRatioOfCaster)
		end
	elseif skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeCurrentHpRelated then 
		RealValueToCaster = params.currentHp * ratio / 100
	elseif skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeTotalHpRelated then 
		RealValueToCaster = params.totalHp * ratio / 100
	end
	return RealValueToCaster , critical
end
function Formulas.getValueOfLifeSteal(damage, skillToCast, params)
	local RealValueToCaster = damage *  (skillToCast.EffectToC.BaseNumber + params.level * skillToCast.EffectToC.DeltaNumber) / 100
	return RealValueToCaster
end
function Formulas.getValueOfDamage(damage, skillToCast, params)
	local RealValueToCaster = damage *  (skillToCast.EffectToC.BaseNumber + params.level * skillToCast.EffectToC.DeltaNumber) / 100
	return RealValueToCaster
end
function Formulas.getValueToReceiver(skillToCast, selfParams, receiverParams)
	local attackOfCaster = Formulas.getBaseValue(selfParams, "Atk")
	local defenceOfReceiver =  Formulas.getBaseValue(receiverParams, "Def")
	local attackRatioOfCaster = Formulas.getRatioValue(selfParams, "Atk")
	local defenceRatioOfReceiver = Formulas.getRatioValue(receiverParams, "Def")
	local CriV = (skillToCast.CriV + selfParams.base.CriV + selfParams.fever.CriV + selfParams.gift.CriV + selfParams.captain.CriV + Formulas.convertRatingToPercentage(selfParams.buff.CriV + selfParams.equipment.CriVRating, selfParams.level, selfParams.star, "CriV"))
	local CriP = (skillToCast.CriP + selfParams.base.CriP + selfParams.fever.CriP + selfParams.gift.CriP + selfParams.captain.CriP + Formulas.convertRatingToPercentage(selfParams.buff.CriV + selfParams.equipment.CriPRating, selfParams.level, selfParams.star, "CriP"))

	local criticalDefenceOfReceiver = (receiverParams.base.ResistCriticalDamage + receiverParams.fever.ResistCriticalDamage + receiverParams.gift.Resists + receiverParams.captain.ResistCriticalDamage +Formulas.convertRatingToPercentage(receiverParams.equipment.ResistCriticalDamage + receiverParams.buff.ResistCriticalDamage, receiverParams.level, receiverParams.star, "Resists"))
	
	local ratio = (skillToCast.EffectToR.BaseNumber + selfParams.level * skillToCast.EffectToR.DeltaNumber)

	local RealValueToReceiver = 0
	local critical = false 

	if skillToCast.EffectToR.Type == Macros.EffectTypeOnFighter.eTypeAttackRelated then
		if CriP > Functions.RandomBetweenLowAndUp(0,100) then
			critical = true
			print ("critical!") 
			if ratio < 0 then -- 加血技能 不考虑暴击抗性
				ratio = CriV * ratio 
			else -- 考虑暴击抗性
				ratio = CriV * 100 * ratio / (100 + criticalDefenceOfReceiver) 
			end
		end
		if ratio > 0 then --伤害 考虑防御
			RealValueToReceiver = (attackOfCaster * ratio / 100 - defenceOfReceiver) * math.max(0, (1 + attackRatioOfCaster))/math.max(0, (1 + defenceRatioOfReceiver))
			if RealValueToReceiver <= 1 then 
						RealValueToReceiver = 1 
			end
		else -- 加血 不考虑防御
			RealValueToReceiver = (attackOfCaster * ratio / 100) * math.max(0, (1 + attackRatioOfCaster))
		end
	elseif skillToCast.EffectToR.Type == Macros.EffectTypeOnFighter.eTypeCurrentHpRelated then 
				RealValueToReceiver = (receiverParams.currentHp) * ratio / 100
	elseif skillToCast.EffectToR.Type == Macros.EffectTypeOnFighter.eTypeTotalHpRelated then 
				RealValueToReceiver = (receiverParams.totalHp) * ratio / 100
	end
	local rebound
	if RealValueToReceiver > 0 and receiverParams.buff.DamageRebound ~= 0 then
		print("damage rebound: reduce part")
		rebound = RealValueToReceiver * receiverParams.buff.DamageRebound/100
		RealValueToReceiver = RealValueToReceiver - rebound
	else
		rebound = nil
	end
	return RealValueToReceiver, critical, rebound
end

function Formulas.getFriendMoveAblilty(params)
	return params.base.MoveAbility.Friend
end

function Formulas.getEnemyMoveAblilty(params)
	return params.base.MoveAbility.Enemy
end

function Formulas.getMovePreference(params)
	return params.base.MoveAbility.Preference
end

function Formulas.getHitRate(params)
	return 100 + params.buff.HitRate
end

function Formulas.getMissOfReceiver(params)
	-- local missOfReceiver = (receiver.buffAddon.Miss + receiver.baseMiss)
	return params.base.Miss + params.fever.Miss + params.gift.Miss + params.captain.Miss + Formulas.convertRatingToPercentage(params.buff.Miss + params.equipment.MissRating, params.level, params.star, "Miss")
end

function Formulas.getHitRateOfAttack(missOfReceiver,hitRateOfCaster)
	print("MissofR:", missOfReceiver)
	print("HitrateofC:", hitRateOfCaster)
	print("HitRate:" ,(100 - missOfReceiver)*hitRateOfCaster/100)
	return (100 - missOfReceiver)*hitRateOfCaster/100
end

function Formulas.getBuffSuccessPossibility(buffValue, caster, receiver)
	return (buffValue.BaseSuccess + caster.fighterLvl * buffValue.DeltaSuccess) * caster.fighterStar/receiver.fighterStar + (caster.fighterLvl - receiver.fighterLvl) * (buffValue.BaseSuccess+100*buffValue.DeltaSuccess) / 15
end
-- function Formulas.getInitialHp(params)

-- end
return Formulas