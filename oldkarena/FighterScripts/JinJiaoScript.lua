--
-- Author: Yiran WANG
-- Date: 2014-11-13 21:15:07
--
local Macros = require "Macros"
local FighterInBattle = require "FighterInBattle"
local Functions = require "Functions"
local Tables = require "Tables"
-- local FightBox = import("..layers.FightBox")
-- local F_HpBar = import("..ui.F_HpBar")
local Formulas = require "Formulas"
-- local UI_FlyIntoBox = import("..ui.UI_FlyIntoBox")
local StatManager = require "StatManager"
-- local SkeletonManager = import("..utils.SkeletonManager")
-- local Skeletons = import("..data.Skeletons")
local JinJiao = class("JinJiao", FighterInBattle)

function JinJiao:ctor()
	FighterInBattle.ctor(self)
end

function JinJiao:skillToReceiver(skillToCast, receiver, rangenumber, time)
	--如果格子里面没敌人，不发动任何效果
	-- print("skill to receiver is called")
	-- print("the sender is:",self.fighterName
	-- if not (receiverBox.currentFighter and skillToCast.ReceiverIsFriend == (Functions.Xor(self.isFriend, self.buffAddon.Chaos) == receiverBox.currentFighter.isFriend)) then
	-- 	-- print("")
	-- 	return false
	-- end
	-- -- print("the receiver is:",receiverBox.currentFighter.fighterName)
	-- -- print("")
	-- local receiver = receiverBox.currentFighter
	--敌人死亡或者在位移中不受伤害
	if receiver.fighterState.Dead then
		return false
	end
	if receiver.fighterState.InDisplace then
		return false
	end
	--飞行技能如果已经成功释放，则不会对后面人产生影响
	if skillToCast.HitType ==  Macros.SkillHitType.eFlying and self.skillState.IsCasted then
		return false
	end
	self.skillState.IsCasted = true
	local missOfReceiver = Formulas.getMissOfReceiver(receiver.calculatingParams)
	local hitRateOfCaster = Formulas.getHitRate(self.calculatingParams)
	--要改，记在人物静态数据里面
	local hitTime = {}
   	--这段要根据具体动画来修改
   	for i=1,skillToCast.HitPerBox do
   		hitTime[i] = 0.05*i
   	end
	--可以考虑加一个流程，在第一格的时候讨论是否miss，现在是每一格独立计算
	if Formulas.getHitRateOfAttack(missOfReceiver,hitRateOfCaster) < Functions.RandomBetweenLowAndUp(0,100) and not self.skillToCast.ReceiverIsFriend then
		self.battleField:addProcess( time + hitTime[1], FighterInBattle.miss, {receiver, time + hitTime[1]})
		-- print("Miss!")
	else
		--击打前特殊处理
		if skillToCast.EffectToR.Special ~= 0 then
			if skillToCast.EffectToR.Special.KnockOut then
				local KO = skillToCast.EffectToR.Special.KnockOut
				local possibility = KO.BaseSuccess[self.fighterStar] + self.fighterLvl * KO.DeltaSuccess
				if possibility >= Functions.RandomBetweenLowAndUp(0,100) then
					RealValueToReceiver = Macros.KnockOutValue
					self.battleField:addProcess( time + hitTime[1] , FighterInBattle.effectToReceiver, {self, receiver, skillToCast, RealValueToReceiver, false, nil, time + hitTime[1]})
				elseif not KO.DealDemage then
					self.battleField:addProcess( time + hitTime[1], FighterInBattle.miss, {receiver, time + hitTime[1]})
				end
				return true
			end
		end
		--这里每一击的时间都不一样
		for i = 1, skillToCast.HitPerBox do
			local RealValueToCaster
			local critical
			RealValueToReceiver, critical, rebound = Formulas.getValueToReceiver(skillToCast, self.calculatingParams, receiver.calculatingParams)
			-- local valueindex = 0
			-- valueindex = self.battleField:addProcess( time + hitTime*i , FighterInBattle.changeCurrentHpBy, {receiver, -RealValueToReceiver, time + hitTime*i})
			-- if skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeDamageRelated then 
			self.battleField:addProcess( time + hitTime[i] , FighterInBattle.effectToReceiver, {self, receiver, skillToCast, RealValueToReceiver, critical, rebound, time + hitTime[i]})
			-- end
		end
		--所有击都打完之后加buff
		if self.skillState.LastSkill == "Normal" then
			self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox] , self.addBuff, {self, receiver, "toReceiver", time + hitTime[skillToCast.HitPerBox]})
		end
		--位移效果（其他special效果也找合适的地方写）
		if skillToCast.EffectToR.Special ~= 0 then
		    if skillToCast.EffectToR.Special.Displace then
				self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox], FighterInBattle.setDisplace, {receiver, self, self:getDisplaceBox(skillToCast, receiver, time, hitTime[skillToCast.HitPerBox]), time + hitTime[skillToCast.HitPerBox]} )
			end
		end
	end
	return true
end

function JinJiao:getDisplaceBox(skillToCast, receiver, time, timeafter)
	local boxToSet
	boxOrigin = receiver.currentBox
	boxTarget = self.battleField:getFightBoxByCoordinate({receiver.currentBox.coordinate[1], self.currentBox.coordinate[2]})
	if (boxTarget.currentFighter or 
		boxTarget.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE) then
		boxToSet = boxOrigin
		self.battleField:addProcess( time + timeafter , self.addBuff, {self, receiver, "toReceiver", time + timeafter})
		if boxTarget.currentFighter and boxTarget.currentFighter.isFriend ~= self.isFriend then
			self.battleField:addProcess( time + timeafter , self.addBuff, {self, boxTarget.currentFighter, "toReceiver", time + timeafter})
		end
	else
		boxToSet = boxTarget
	end
	return boxToSet
end

-- function JinJiao:addBuff( receiver, addType, time )
-- 	--加buff
-- 	if receiver.fighterState.Dead then
-- 		return false
-- 	end
-- 	-- print("Add Buff!",self.fighter.Information.Name," to ", receiver.fighter.Information.Name)
-- 	local buffs
-- 	-- 判断要放的是哪个 BUFF
-- 	if addType == "toSelf" then 
-- 		-- print (self.fighter.Information.Name,"manage to buff himself")
-- 		if self.skillState.LastSkill == "Normal" then 
-- 			buffs = self.fighter.NormalAtk.EffectToC.Buffs
-- 			-- print("Normal to C")
-- 		else
-- 			buffs = self.fighter.SuperAtk.EffectToC.Buffs
-- 			-- print("Normal to R")
-- 		end
-- 	else 
-- 		if self.skillState.LastSkill == "Normal" then 
-- 			buffs = self.fighter.NormalAtk.EffectToR.Buffs
-- 			-- print("Super to C")
-- 		else
-- 			buffs = self.fighter.SuperAtk.EffectToR.Buffs
-- 			-- print("Super to R")
-- 		end
-- 	end

-- 	if (not buffs.IsGoodBuff) and (receiver.buffAddon.Invincible or receiver.buffAddon.Immune) then
-- 		-- print("immune bad buffs")
-- 		return false
-- 	end

-- 	for k,v in pairs(buffs) do
-- 		-- 计算 BUFF 添加成功率
-- 		local possibility = Formulas.getBuffSuccessPossibility(v, self, receiver)
-- 		if k == "Stun" then 
-- 				print("金角大王来巡山",receiver.fighterName)

-- 				-- print(self.fighterName, "manage to add buff to", receiver.fighterName)
-- 				-- print(possibility, "% success")
-- 			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Stun + receiver.giftAddon.Resists + receiver.captainAddon.ResistStun + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistStun + receiver.equipmentsAddon.ResistStun, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
-- 		elseif k == "Freeze" then 
-- 			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Freeze + receiver.giftAddon.Resists + receiver.captainAddon.ResistFreeze + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistFreeze + receiver.equipmentsAddon.ResistFreeze, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
-- 		elseif k == "Disarm" then 
-- 			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Disarm + receiver.giftAddon.Resists + receiver.captainAddon.ResistDisarm + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistDisarm + receiver.equipmentsAddon.ResistDisarm, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
-- 		end

-- 		-- print("attempt to add buff:",k,"p=",possibility,"from",self.fighter.Information.Name,"to",receiver.fighter.Information.Name)
-- 		if possibility >= Functions.RandomBetweenLowAndUp(0,100) then
-- 			-- print("add success")
-- 			-- 如果已经有同一人放的同一技能带来的同种效果则覆盖掉旧的效果
-- 			for l,m in pairs(receiver.currentBuffs) do
-- 				if l.fighter and l.fighter == self and l.normalOrSuper == self.skillState.LastSkill and l.buffType == k then 
-- 					-- 去除掉旧效果的影响
-- 					if type(m.target[l.buffType]) == "boolean" then 
-- 						m.target[l.buffType] = false
-- 					else
-- 						m.target[l.buffType] = m.target[l.buffType] - m.value 
-- 						if l.buffType == "Hp" then
-- 							local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
-- 							local hpDifference = updatedTotalHp - receiver.totalHp
-- 							receiver:changeCurrentHpBy(hpDifference, time, false, "total")
-- 						end
-- 					end
-- 					receiver.currentBuffs[l] = nil
-- 					break
-- 				end
-- 				--remove bad buffs
-- 				if k == "Remove" and m.IsGoodBuff == false then
-- 					print("Remove:" ,l.buffType, "added from:", l.fighter.fighterName, "of:", receiver.fighterName)
-- 					-- print(m.IsGoodBuff)
-- 					if type(m.target[l.buffType]) == "boolean" then 
-- 						m.target[l.buffType] = false
-- 					else
-- 						m.target[l.buffType] = m.target[l.buffType] - m.value 
-- 						if l.buffType == "Hp" then
-- 							local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
-- 							local hpDifference = updatedTotalHp - receiver.totalHp
-- 							receiver:changeCurrentHpBy(hpDifference, time, false, "total")
-- 						end
-- 					end
-- 					receiver.currentBuffs[l] = nil
-- 				end
-- 			end
-- 			if k == "Remove" then
-- 				print("Remove bad buffs")
-- 			else
-- 				-- 生成 BUFF
-- 				local buffkey = {
-- 					fighter = self,
-- 					normalOrSuper = self.skillState.LastSkill,
-- 					buffType = k,
-- 				}
-- 				local buffvalue = {
-- 					value = v.BaseNumber + self.fighterLvl * v.DeltaNumber,
-- 					time = math.floor(v.BaseTime + self.fighterLvl * v.DeltaTime),
-- 					IsGoodBuff = v.IsGoodBuff
-- 				}
-- 				-- 攻击 防御 改变要根据具体攻击力和防御力来计算 毒和流血要计算抗性
-- 				-- if k == "Atk" then 
-- 				-- 	buffvalue.value = receiver.baseAttack * buffvalue.value / 100
-- 				-- elseif k == "Def" then 
-- 				-- 	buffvalue.value = receiver.baseDefence * buffvalue.value / 100
-- 				if k == "Poison" then 
-- 					buffvalue.value = buffvalue.value * 100 / (100 + receiver.fighter.Resistance.Poison + receiver.giftAddon.Resists + receiver.captainAddon.ResistPoison + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistPoison + receiver.equipmentsAddon.ResistPoison, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
					
-- 				elseif k == "Bleeding" then 
-- 					buffvalue.value = buffvalue.value * 100 / (100 + receiver.fighter.Resistance.Bleeding + receiver.giftAddon.Resists + receiver.captainAddon.ResistBleeding + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistBleeding + receiver.equipmentsAddon.ResistBleeding, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
-- 				end
-- 				-- 记录 BUFF 在施放对象中的效果对应表以方便索引
-- 				buffvalue.target = receiver.buffAddon
-- 				-- 添加新效果的影响
-- 				if type(buffvalue.target[k]) == "boolean" then 
-- 					buffvalue.target[k] = true
-- 					-- print("boolean buff")
-- 				else
-- 					if k == "Hp" or k == "Atk" or k == "Def" then
-- 						buffvalue.value = buffvalue.value * Macros.STARCOEFFCIENT ^ (self.fighterStar - 1)
-- 					end
-- 					print(k, buffvalue.target[k], buffvalue.value)
-- 					buffvalue.target[k] = buffvalue.target[k] + buffvalue.value
-- 					if k == "Hp" then
-- 						-- print ("add hp buff")
-- 						local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
-- 						local hpDifference = updatedTotalHp - receiver.totalHp
-- 						receiver:changeCurrentHpBy(hpDifference, time, false, "total")
-- 						-- receiver.battleField:addProcess( time, receiver.changeCurrentHpBy, {receiver, buffvalue.value, time, false, "total"})
-- 					end
-- 					-- print("value buff")
-- 				end
-- 				-- 挂上 BUFF
-- 				receiver.currentBuffs[buffkey] = buffvalue
-- 				receiver.battleField:addPlay( time , receiver.playAddBuffAnimation, {receiver, buffkey, time} )
-- 			end
-- 		end
-- 		return true
-- 	end
-- end


return JinJiao