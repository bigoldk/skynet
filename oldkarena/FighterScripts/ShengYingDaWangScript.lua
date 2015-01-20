--
-- Author: Yiran WANG
-- Date: 2014-11-05 09:25:15
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
local ShengYingDaWang = class("ShengYingDaWang", FighterInBattle)

function ShengYingDaWang:ctor()
	FighterInBattle.ctor(self)
end

function ShengYingDaWang:skillToReceiver(skillToCast, receiver, rangenumber, time)
	--如果格子里面没敌人，不发动任何效果
	-- print("skill to receiver is called")
	-- print("the sender is:",self.fighterName
	--敌人死亡或者在位移中不受伤害
	print(receiver.fighter.Name)
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
		--这里每一击的时间都不一样
		for i = 1, skillToCast.HitPerBox do
			local RealValueToCaster
			local critical
			RealValueToReceiver, critical = Formulas.getValueToReceiver(skillToCast, self.calculatingParams, receiver.calculatingParams)
			if self.skillState.LastSkill == "Super" and rangenumber == 6 then
				RealValueToReceiver = RealValueToReceiver*1.5
			end
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

function ShengYingDaWang.setBoxSpecialEffect(box, normalorsuper, rangenumber)
	box:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setColor(ccc3(0,255,0))
	box:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setOpacity(192)
end

return ShengYingDaWang