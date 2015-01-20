--
-- Author: Yiran WANG
-- Date: 2014-11-13 20:25:05
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
local BaiLuJing = class("BaiLuJing", FighterInBattle)

function BaiLuJing:ctor()
	FighterInBattle.ctor(self)
end

function BaiLuJing:skillToReceiver(skillToCast, receiver, rangenumber, time)
	--如果格子里面没敌人，不发动任何效果
	-- print("skill to receiver is called")
	-- print("the sender is:",self.fighterName
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
	local box = receiver.currentBox
	local boxUp = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] + 1})
	local boxDown = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] - 1})
	if boxUp and (boxUp.currentFighter and skillToCast.ReceiverIsFriend == (Functions.Xor(self.isFriend, self.buffAddon.Chaos) == boxUp.currentFighter.isFriend)) then
		local receiver = boxUp.currentFighter
		self:skillToReceiver2(skillToCast, receiver, rangenumber, time)
	end
	if boxDown and (boxDown.currentFighter and skillToCast.ReceiverIsFriend == (Functions.Xor(self.isFriend, self.buffAddon.Chaos) == boxDown.currentFighter.isFriend)) then
		local receiver = boxDown.currentFighter
		self:skillToReceiver2(skillToCast, receiver, rangenumber, time)
	end
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
		--这里每一击的时间都不一样
		for i = 1, skillToCast.HitPerBox do
			local RealValueToCaster
			local critical
			RealValueToReceiver, critical = Formulas.getValueToReceiver(skillToCast, self.calculatingParams, receiver.calculatingParams)
			-- local valueindex = 0
			-- valueindex = self.battleField:addProcess( time + hitTime*i , FighterInBattle.changeCurrentHpBy, {receiver, -RealValueToReceiver, time + hitTime*i})
			-- if skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeDamageRelated then 
			self.battleField:addProcess( time + hitTime[i] , FighterInBattle.effectToReceiver, {self, receiver, skillToCast, RealValueToReceiver, critical, nil, time + hitTime[i]})
			-- end
		end
		--所有击都打完之后加buff
		self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox] , self.addBuff, {self, receiver, "toReceiver", time + hitTime[skillToCast.HitPerBox]})
	end
	return true
end

function BaiLuJing:skillToReceiver2(skillToCast, receiver, rangenumber, time)
	--如果格子里面没敌人，不发动任何效果
	-- print("skill to receiver is called")
	-- print("the sender is:",self.fighterName
	--敌人死亡或者在位移中不受伤害
	if receiver.fighterState.Dead then
		return false
	end
	if receiver.fighterState.InDisplace then
		return false
	end
	--飞行技能如果已经成功释放，则不会对后面人产生影响
	local missOfReceiver = Formulas.getMissOfReceiver(receiver.calculatingParams)
	local hitRateOfCaster = Formulas.getHitRate(self.calculatingParams)
	--要改，记在人物静态数据里面
	local hitTime = {}
   	--这段要根据具体动画来修改
   	for i=1,skillToCast.HitPerBox do
   		hitTime[i] = 0.05*i + 0.1
   	end
	--可以考虑加一个流程，在第一格的时候讨论是否miss，现在是每一格独立计算
	if Formulas.getHitRateOfAttack(missOfReceiver,hitRateOfCaster) < Functions.RandomBetweenLowAndUp(0,100) and not self.skillToCast.ReceiverIsFriend then
		self.battleField:addProcess( time + hitTime[1], FighterInBattle.miss, {receiver, time + hitTime[1]})
		-- print("Miss!")
	else
		--这里每一击的时间都不一样
		for i = 1, skillToCast.HitPerBox do
			local RealValueToCaster
			local critical
			RealValueToReceiver, critical = Formulas.getValueToReceiver(skillToCast, self.calculatingParams, receiver.calculatingParams)
			RealValueToReceiver = RealValueToReceiver * 0.5
			-- local valueindex = 0
			-- valueindex = self.battleField:addProcess( time + hitTime*i , FighterInBattle.changeCurrentHpBy, {receiver, -RealValueToReceiver, time + hitTime*i})
			-- if skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeDamageRelated then 
			self.battleField:addProcess( time + hitTime[i] , FighterInBattle.effectToReceiver, {self, receiver, skillToCast, RealValueToReceiver, critical, nil, time + hitTime[i]})
			-- end
		end
		--所有击都打完之后加buff
		self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox] , self.addBuff, {self, receiver, "toReceiver", time + hitTime[skillToCast.HitPerBox]})
	end
	return true
end

function BaiLuJing.setBoxSpecialEffect(box, normalorsuper, rangenumber)
	local boxUp = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] + 1})
	local boxDown = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] - 1})
	if boxUp then
		boxUp:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(255,0,0))
		boxUp:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(192)
	end
	if boxDown then
		boxDown:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(255,0,0))
		boxDown:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(192)
	end
	box.specialNeedToRemove = {normalorsuper, rangenumber}
end

function BaiLuJing.removeBoxSpecialEffect(box, normalorsuper, rangenumber)
	local boxUp = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] + 1})
	local boxDown = box.battleField:getFightBoxByCoordinate({box.coordinate[1], box.coordinate[2] - 1})
	if boxUp then
		boxUp:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(0,0,0))
		if boxUp.accessable then
			boxUp:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(0)
		else
			boxUp:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(128)
		end
	end
	if boxDown then
		boxDown:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(0,0,0))
		if boxDown.accessable then
			boxDown:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(0)
		else
			boxDown:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(128)
		end
	end
	box.specialNeedToRemove = nil
end

return BaiLuJing