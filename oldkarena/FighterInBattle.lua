-- Author: Yiran WANG
-- altered by HUO Da

local FighterInBattle = class("FighterInBattle")
local Macros = require "Macros"
local Functions = require "Functions"
local Tables = require "Tables"
-- local FightBox = import(".FightBox")
-- local F_HpBar = import("..ui.F_HpBar")
local Formulas = require "Formulas"
-- local UI_FlyIntoBox = import("..ui.UI_FlyIntoBox")
local StatManager = require "StatManager"

--战斗展示函数
function FighterInBattle:playUnderAttack( time, isCritical)
	-- print("playUnderAttack------------------")
	-- if self.type == "cocostudio" then
	-- 	self.armature:getAnimation():play("smitten")
 --    else
 --    	-- if not self.isFriend  then
 --    	-- SkeletonManager.smitten(self.armature,Skeletons.zhubajie)
 --        -- else
 --        SkeletonManager.smitten(self.armature,self.fighter.Skeleton)       
 --        return self.fighter.Skeleton.actions.smitten[2]/30
 --        -- end    
 --    end   	
 	return ({"playUnderAttack",self.fighter.Skeleton.actions.smitten[2]/30})
end

function FighterInBattle:playNormal(time)
	-- print("playNormal------------------")
	-- if self.type == "cocostudio" then
	-- 	self.armature:getAnimation():play("loading")
 --    else
 --    	-- if not self.isFriend then
 --    	-- SkeletonManager.idle(self.armature,Skeletons.zhubajie)
 --     --    else
 --    	SkeletonManager.idle(self.armature,self.fighter.Skeleton)
 --    	return self.fighter.Skeleton.actions.idle[2]/30
 --        -- end
 --    end 
 	return ({"playNormal",self.fighter.Skeleton.actions.idle[2]/30})
end

function FighterInBattle:playMiss( time )
	-- print("playMiss------------------")
	-- if self.type == "cocostudio" then
	-- 	self.armature:getAnimation():play("smitten")
 --    else
 --    	-- if not self.isFriend then
 --    	-- 	SkeletonManager.smitten(self.armature,Skeletons.zhubajie)
 --     --    else
 --        	SkeletonManager.smitten(self.armature,self.fighter.Skeleton)
 --        	return self.fighter.Skeleton.actions.smitten[2]/30
 --        -- end
 --    end
 	return ({"playMiss",self.fighter.Skeleton.actions.smitten[2]/30})
end

function FighterInBattle:playDeath(time)
	-- print("playDeath------------------")
	--配合fightscene的游戏进程管理系统，死亡计数决定游戏是否结束，所以只有在死亡动画播放时才能在计数器加1
	--将死去的人物从场上人物列表中去掉，并且在死亡计数器加1
	-- local camp = 0
	-- if self.isFriend then
	-- 	camp = "Friend"
	-- else
	-- 	camp = "Enemy"
	-- 	-- enemy 死亡后掉箱子
	-- 	local x = self:getPositionX()
	-- 	local y = self:getPositionY()
	-- 	for i=1,#self.droppedItem do
	-- 		local name = self.droppedItem[i]
	-- 		-- 掉落的物品放入列表
	-- 		-- local battleField = self.battleField
	-- 		-- table.insert(battleField.itemDroppedFromEnemy,name)
	-- 		local item_sprite = display.newSprite(name):addTo(self.battleField)
	-- 		item_sprite:setPosition(CCPoint(x,y-50))
        	
 --        	local moveto = CCMoveTo:create(0.5,CCPoint(100, display.height-180))
	--     	local scaleto = CCScaleTo:create(0.5,0.3)
	--     	local action = CCSpawn:createWithTwoActions(moveto,scaleto)
 --   	    	transition.execute(item_sprite,action,
 --   	    		{delay = 0.5,easing = "sineIn", 
 --   	    		onComplete = function() 
 --   	    		-- local number = self.battleField.item_number:getString() 
 --   	    		-- number = number + 1
 --   	    		-- self.battleField.item_number:setString(number) 
 --   	    		item_sprite:removeSelf() 
 --   	    		end})
	-- 	end		
 --    end

	local indextoremove = 0
	for index, checkfighter in pairs(self.battleField.currentFighters[camp]) do 
		if checkfighter == self then
			indextoremove = index
			break
		end
	end
	self.battleField.currentFighters[camp][indextoremove] = nil
	if self.isFriend then
		self.battleField.friendFinished = self.battleField.friendFinished + 1
		print("one friend dead")
	else
		self.battleField.enemyFinished = self.battleField.enemyFinished + 1
		print("one enemy dead")
	end
	print("flagege here,",self.camp)
	self.battleField.fighterDead[camp] = self.battleField.fighterDead[camp] + 1
	-- --播放死亡动画
	
	-- if self.type == "cocostudio" then
	-- 	self.armature:getAnimation():play("death")
 --    else
 --    	-- if not self.isFriend then
 --    	-- SkeletonManager.death(self.armature,Skeletons.zhubajie)
 --     --    else
 --        SkeletonManager.death(self.armature,self.fighter.Skeleton)
 --        return self.fighter.Skeleton.actions.death[2]/30
 --        -- end
 --    end
 	return ({"playDeath",self.fighter.Skeleton.actions.death[2]/30})
end

function FighterInBattle:playHpChangeAnimation( totalHp, currentHp, changedHp, isCritical, type, time )
	-- print("playHpChangeAnimation------------------")
	--传入的hp为float，其作用是为了判断“0血”是加血还是减血
	--实际伤血为int
	-- local maozi
	-- if changedHp == -Macros.KnockOutValue then
	-- 	maozi = CCLabelTTF:create("秒杀！","Arial", 40)
	-- else
	-- 	local realChangedHp = Functions.getInteger(changedHp)
	-- 	--加冒字效果
	-- 	if type == "total" then
	-- 		maozi = CCLabelTTF:create("总血量"..math.abs(realChangedHp), "Arial", 40)
	-- 	else
	-- 		maozi = CCLabelTTF:create(math.abs(realChangedHp), "Arial", 40)
	-- 	end
	-- end
	-- if changedHp < 0 then
	-- 	maozi:setColor(ccc3(255,0,0))
	-- else
	-- 	maozi:setColor(ccc3(0,255,0))
	-- end
 --   	maozi:setPosition(ccp(0,120))
 --   	self:addChild(maozi,100000)
 --   	local x = Functions.RandomBetweenLowAndUp(-75, 75)
 --   	local move = CCMoveBy:create(0.8, ccp(x,300))
 --   	local function removemaozi( maozi )
 --   		maozi:removeFromParent()
 --   	end
 --   	local remove = CCCallFuncN:create(removemaozi)
 --   	local maoziact = CCSequence:createWithTwoActions(move,remove)
 --   	maozi:runAction(maoziact)
 --   	--血条长度
	-- self.hpbar:setPercentage(currentHp / totalHp)
	-- return 0.8
	-- print("percentage",self.hpbar.top:getPercentage())
	return ({"playHpChangeAnimation",0.8})
end

function FighterInBattle:playCastSkill( skillType, section, time )
	
	-- section = "after"：播技能弹道动画以及施法者后摇
	if skillType == "Super" then 
		if section == "before" then		
			-- print("before")
			-- print("playcastskill------------------")
			if self.type == "cocostudio" then
			  -- self.armature:getAnimation():play("attack")
    	    else
    	   --  	if not self.isFriend then
    		  -- SkeletonManager.superatk(self.armature,Skeletons.zhubajie)
    		  --   else
    	      	-- SkeletonManager.superatkQian(self.armature,self.fighter.Skeleton)
    	      	return ({"playCastSkill",self.fighter.Skeleton.actions.superatkQian[2]/30})
    		    -- end
    	    end
		elseif section == "after" then
			-- print("after:",self.fighterName)
			-- print("playcastskill------------------")
			-- print("")
			if self.type == "cocostudio" then
			  -- self.armature:getAnimation():play("attack")
    	    else
    	 --    	if not self.isFriend then
    		--   SkeletonManager.superatk(self.armature,Skeletons.zhubajie)
    		-- else
    			-- SkeletonManager.superatkHou(self.armature,self.fighter.Skeleton)
    			-- SkeletonManager.superdandao(self.dandao)
    			return ({"playCastSkill",math.max(self.fighter.Skeleton.actions.superatkHou[2]/30, self.fighter.Skeleton.actions.superDandao/30)})
    		-- end
    	    end
		end
	else
		if section == "before" then		
			-- print("before")
			-- print("playcastskill------------------")
			if self.type == "cocostudio" then
			  -- self.armature:getAnimation():play("attack")
    	    else
    	 --    	if not self.isFriend then
    		--   SkeletonManager.normalatk(self.armature,Skeletons.zhubajie)
    		-- else
    	      -- SkeletonManager.normalatkQian(self.armature,self.fighter.Skeleton)
    	      return ({"playCastSkill",self.fighter.Skeleton.actions.normalatkQian[2]/30})
    	    -- end
    	    end
		elseif section == "after" then
			-- print("after:",self.fighterName)
			-- print("playcastskill------------------")
			-- print("")
			if self.type == "cocostudio" then
			  -- self.armature:getAnimation():play("attack")
    	    else
    	 --    	if not self.isFriend then
    		--   SkeletonManager.normalatk(self.armature,Skeletons.zhubajie)
    		-- else 
    			-- SkeletonManager.normalatkHou(self.armature,self.fighter.Skeleton)
    			-- SkeletonManager.normaldandao(self.dandao)
    			return ({"playCastSkill",math.max(self.fighter.Skeleton.actions.normalatkHou[2]/30, self.fighter.Skeleton.actions.normalDandao/30)})
    		-- end
    	    end
		end
	end
	-- return("playCastSkill")
end

function FighterInBattle:playAddBuffAnimation( buffkey, time )
	-- print("playAddBuff------------------")
	-- print("Add buff: ", buff)
	if buffkey.buffType == "Chaos" then
		self.chaosSwitch = true
	end
	return ({"playAddBuffAnimation"})
end

function FighterInBattle:playRemoveBuffAnimation( buffkey, time )
	-- print("playRemoveBuff------------------")
	if buffkey.buffType == "Chaos" then
		self.chaosSwitch = false
	end
	return ({"playRemoveBuffAnimation"})
end

--逻辑
function FighterInBattle:preCastSkill( time )
	print(self.fighterName,"precast is called")
	-- print("")
	--抬手事件
	--如果角色在准备抬手时已经死亡，或者在位移中，或者被晕眩或者禁魔，则取消抬手事件
	if self.fighterState.Dead then
		print(self.fighterName,"  dead, so cannot precast")
		return false
	end
	if self.fighterState.InDisplace then
		print("InDisplace")
		return false
	end
	if self.buffAddon.Disarm or self.buffAddon.Stun then
		print("Disarm or stun")
        return false
   	end
   	--判断是大招还是小招，以后要改
	if self.skillState.IsReadyToCastSuper then 
		print(self.fighterName," playing Super")

		self.skillToCast = self.fighter.SuperAtk
		self.skillState.LastSkill = "Super"
		self.skillState.CoolDown = self.fighter.SuperAtk.CD
		self.skillState.IsReadyToCastSuper = false
	else
		print(self.fighterName," playing normal")
		self.skillState.LastSkill = "Normal"
		self.skillToCast = self.fighter.NormalAtk
	end
	self.skillState.IsCasted = false --用来标记飞行技能是否放出
	--抬手时看到目标范围内有人才会继续
	local toCast = false
	if type(self.skillToCast.Range) == "table" then
		local i=1
		for rangek,rangev in pairs(self.skillToCast.Range) do
			print("range:",i)
			i = i+1
			if not self.isFriend and not self.buffAddon.Chaos then
				rangev = {-rangev[1],rangev[2]}
			end
			local posOfBox = self.currentBox:getPosOfRelativeBox(rangev)
			print("posOfBox",unpack(posOfBox))
			if posOfBox[1] ~= 0 then 
				local toCheck = self.battleField:getFightBoxByCoordinate(posOfBox)
				if toCheck.currentFighter and self.skillToCast.ReceiverIsFriend == (Functions.Xor(self.isFriend, self.buffAddon.Chaos) == toCheck.currentFighter.isFriend) then 
					toCast = true
				elseif self.skillState.LastSkill == "Super" then
					toCast = true
				end
			end
		end
	else
		toCast = true
	end
	if toCast then
		print("start")
		self.battleField:addPlay( time, self.playCastSkill, {self, self.skillState.LastSkill, "before", time} )
		print("end")
		local qianyaoTime --抬手动作时间，时间过后判断是否能放出招
		if self.skillState.LastSkill == "Super" then
			qianyaoTime = self.fighter.Skeleton.actions.superatkQian[2]/30
		else
			qianyaoTime = self.fighter.Skeleton.actions.normalatkQian[2]/30
		end
		self.battleField:addProcess( time + qianyaoTime , self.castSkill, {self, self.skillToCast,  time + qianyaoTime})		
	end
	return true
end

function FighterInBattle:castSkill( skillToCast, time )
	--放招（就是弹道出去了）break条件同上
	-- print(self.fighterName,"cast is called")
	-- print("")
	if self.fighterState.InDisplace then
		return false
	end
	if self.fighterState.Dead then
		print(self.fighterName,"  dead, so cannot cast")
		return false
	end
	if self.buffAddon.Disarm or self.buffAddon.Stun then
		print("disarmed or stuned")
        return false
   	end
   	if self.notacted then
   		self.notacted = false
   	end
   	--每一格子的效果分别在弹道播出的哪一时刻
   	--要改，记在人物静态数据里面
   	local hitBoxTime = {}
   	--这段要根据具体动画来修改
   	if type(skillToCast.Range) == "table" then
   		for i=1,#skillToCast.Range do
   			hitBoxTime[i] = 0.05*i
   		end
   		for rangek,rangev in pairs(skillToCast.Range) do
			if not Functions.Xor(self.isFriend, self.buffAddon.Chaos)  then
				rangev = {-rangev[1],rangev[2]}
			end
			local posOfBox = self.currentBox:getPosOfRelativeBox(rangev)
			if posOfBox[1] ~= 0 then 
				local toCheck = self.battleField:getFightBoxByCoordinate(posOfBox)
				--对格子作用（放阵招人等，可以先写一些判断语句，比如成功率etc）
				--注意这里传入的参数是格子，也就是弹道在每一时刻飞到了哪个格子，具体那个格子是否有人要飞过去再看
				self.battleField:addProcess( time + hitBoxTime[rangek] , self.skillToBox, {self, skillToCast, toCheck, rangek, time + hitBoxTime[rangek]})
			end
		end
	else
		hitBoxTime = {0.2}
		local camp
		if Functions.Xor(self.isFriend, skillToCast.ReceiverIsFriend) then
			camp = "Enemy"
		else
			camp = "Friend"
		end
		local targetTable
		if skillToCast.Range == "All" then
			targetTable = self.battleField.currentFighters[camp]
		else
			for i=1,5 do
				if skillToCast.Range == "Rand"..i then
					targetTable = Functions.GetCombination( self.battleField.currentFighters[camp], i )
					break
				end
			end
		end
		for k,receiver in pairs(targetTable) do
			print()
			self.battleField:addProcess( time + hitBoxTime[1] , self.skillToReceiver, {self, skillToCast, receiver, rangek, time + hitBoxTime[1]})
		end
	end


	local timeToCaster = 0.2--对自己的作用的延迟时间
	self.battleField:addProcess( time + timeToCaster , self.skillToCaster, {self, skillToCast, time + timeToCaster})
	self.battleField:addPlay( time, self.playCastSkill, {self, self.skillState.LastSkill, "after", time} )
   	return true
end

function FighterInBattle:skillToCaster(skillToCast, time)
	--如果自己死了，那么对自己的效果加不上
	-- print(self.fighterName,"skilltoself")
	if self.fighterState.Dead then
		print(self.fighterName,"  dead, so cannot skilltoself")
		return false
	end
	local RealValueToCaster
	local critical
	RealValueToCaster, critical = Formulas.getValueToCaster(skillToCast, self.calculatingParams)

	local timeToCaster = 0.2--弹道作用到减血（加Buff）的时间差
	if not RealValueToCaster == 0 then
		self.battleField:addProcess( time + timeToCaster , self.effectToCaster, {self, skillToCaster, RealValueToCaster, critical, time + timeToCaster})
	end
	self.battleField:addProcess( time + timeToCaster , self.addBuff, {self, self, "toSelf", time + timeToCaster})
	return true
end

function FighterInBattle:effectToCaster(skillToCast, RealValueToCaster, critical, time)
	local hpchanged = self:changeCurrentHpBy(-RealValueToCaster, time, critical, "nonlethal")
	self.statManager:restoreHealth(hpchanged)
	if critical then
		self.statManager:CriticalAttack()
	end
end

function FighterInBattle:skillToBox(skillToCast, receiverBox, rangenumber, time)
	if not (receiverBox.currentFighter and skillToCast.ReceiverIsFriend == (Functions.Xor(self.isFriend, self.buffAddon.Chaos) == receiverBox.currentFighter.isFriend)) then
		return false
	else
		local receiver = receiverBox.currentFighter
		self:skillToReceiver(skillToCast, receiver, rangenumber, time)
	end
end

function FighterInBattle:skillToReceiver(skillToCast, receiver, rangenumber, time)
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
		print("dead already")
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
					return true
				elseif not KO.DealDemage then
					self.battleField:addProcess( time + hitTime[1], FighterInBattle.miss, {receiver, time + hitTime[1]})
					return true
				end
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
		self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox] , self.addBuff, {self, receiver, "toReceiver", time + hitTime[skillToCast.HitPerBox]})
		--位移效果（其他special效果也找合适的地方写）
		if skillToCast.EffectToR.Special ~= 0 then
		    if skillToCast.EffectToR.Special.Displace then
				self.battleField:addProcess( time + hitTime[skillToCast.HitPerBox], FighterInBattle.setDisplace, {receiver, self, self:getDisplaceBox(skillToCast, receiver), time + hitTime[skillToCast.HitPerBox]} )
			end
		end
	end
	return true
end

function FighterInBattle:getDisplaceBox(skillToCast, receiver)
	local boxToSet = 0
	local iter = 1
	while (boxToSet == 0 or 
		boxToSet.currentFighter or 
		boxToSet.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE) and iter <= #skillToCast.EffectToR.Special.Displace.Distance do
		local RelDis = clone(skillToCast.EffectToR.Special.Displace.Distance[iter])
		local posOfBox = RelDis
		if skillToCast.EffectToR.Special.Displace.PointRefX == "Self" then
			if not self.isFriend then
				RelDis[1] = -RelDis[1]
			end
			posOfBox[1] = self.currentBox.coordinate[1] + RelDis[1]
		elseif skillToCast.EffectToR.Special.Displace.PointRefX == "Receiver" then
			if not receiver.isFriend then
				RelDis[1] = -RelDis[1]
			end
			posOfBox[1] = receiver.currentBox.coordinate[1] + RelDis[1]
		end
		if skillToCast.EffectToR.Special.Displace.PointRefY == "Self" then
			posOfBox[2] = self.currentBox.coordinate[2] + RelDis[2]
		elseif skillToCast.EffectToR.Special.Displace.PointRefY == "Receiver" then
			posOfBox[2] = receiver.currentBox.coordinate[2] + RelDis[2]
		end
		-- print("boxtoset", boxToSet, "iter", iter)
		-- print("posOfBox", posOfBox[1], posOfBox[2])
		if posOfBox[1] ~=0 then
			boxToSet = self.battleField:getFightBoxByCoordinate(posOfBox)
		else
			boxToSet = 0
		end
		-- print("boxtoset", boxToSet, "iter", iter)
		iter = iter + 1
	end
	if (boxToSet == 0 or 
		boxToSet.currentFighter or 
		boxToSet.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE) then
		boxToSet = receiver.currentBox
	end
	print("boxtoset")
	return boxToSet
end

function FighterInBattle:effectToReceiver(receiver, skillToCast, RealValueToReceiver, critial, rebound, time)
	-- local damage = 0
	-- if valueindex ~= 0 then
		-- damage =  self.battleField.processReturnList[valueindex]
	-- end
	-- print("effect is called")
	print("critical, ",critical)
	print("time in effectotreceiver,",time)
	print("self.statmanager",self.statManager)
	local  temp = receiver:changeCurrentHpBy(-RealValueToReceiver, time, critical)
	local hpchanged  = temp[2]
	local killed = temp[3]
	print("hpchanged,",hpchanged,killed)
	if killed then
		self.statManager:killEnemy(receiver)
	end
	if critical then
		self.statManager:CriticalAttack()
	end
	if receiver.isFriend == self.isFriend then
		self.statManager:restoreHealth(hpchanged)
	else
		print("self.statmanager,",self.fighterName)
		self.statManager:dealDamage(-hpchanged)
		if hpchanged < 0 then
			receiver.statManager:receiveDamage(-hpchanged)
		end
	end
	if skillToCast.EffectToC.Type == Macros.EffectTypeOnFighter.eTypeDamageRelated and hpchanged < 0 then 
		local RealValueToCaster = Formulas.getValueOfLifeSteal(-hpchanged, skillToCast, self.calculatingParams)
		self:changeCurrentHpBy(RealValueToCaster, time, false, "nonlethal")
	end
	if rebound then
		self:changeCurrentHpBy(-rebound, time, false)
	end
end

function FighterInBattle:setDisplace(caster, boxToSet, time)
	--位移效果，位移者为自己，传入使自己位移的角色
	--break：如果位移格子不存在，不可达，或者自己已经死亡
	if boxToSet == 0 then
		return false
	end
	if self.fighterState.Dead then
		return false
	end
	-- if boxToSet.currentFighter or boxToSet.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE then
	-- 	return false
	-- end
	--现在的格子设空
	self.currentBox:setEmpty()
	--要到达的格子设满
	self.battleField:setCharacterDataToPosition(boxToSet, self)
	--加一个位移中的tag，位移中不受伤
	self.fighterState.InDisplace = true
	--要改，记在人物静态数据里面
	local setDisplaceTime = 0.2--位移延迟
	self.battleField:addPlay(time, self.battleField.moveCharacterToCurrent, {self.battleField, self})
	self.battleField:addProcess( time + setDisplaceTime, FighterInBattle.finishDisplace, {self, time + setDisplaceTime} )
end

function FighterInBattle:finishDisplace( time )
	if self.fighterState.Dead then
		return false
	end
	--位移结束后，取消位移中的tag
	self.fighterState.InDisplace = false
end

function FighterInBattle:miss(time)
	--如果miss成功，则播放miss效果，并且重置挨打动画
	--冻结或者晕眩的人不会播miss动画
	--死人直接break
	-- print("miss is called")
	if  (self.buffAddon.Freeze or self.buffAddon.Stun or self.fighterState.Dead) then -- 眩晕或者冻结不播miss动画
		return false
	end
	self.battleField:addPlay( time, FighterInBattle.playMiss, {self, time})
	-- local missTime = self.fighter.Skeleton.actions.smitten[2]/30
	-- self.battleField:addProcess( time + missTime, self.recoveryFromAttack, {self, time + missTime} )
	return true
end

function FighterInBattle:death (time)
	--死亡事件
	--如果已经死亡，则不需要继续执行
	print(self.fighterName,"dead")
	if self.fighterState.Dead then
		return false
	end
	if self.isFriend then
		camp = "Friend"
	else
		camp = "Enemy"
	end
	--格子设空
	self.currentBox:setEmpty()
	-- 如果是队长则移除队长技能效果
	if self.isCaptain then 
		for _, fighter in pairs(self.battleField.currentFighters[camp]) do
			fighter:addOrRemoveCaptainBuff(self.fighter, "Remove", time)
		end
	end
	--增加一个死亡tag
	self.fighterState.Dead = true
	self.battleField:addPlay( time, self.playDeath, {self, time} )
	-- Yi Feng
	-- there is something wrong here...
	local deathTime = self.fighter.Skeleton.actions.death[2]/30--死亡延迟时间
	self.battleField:addPlay( time + deathTime, self.setVisible, {self,false})
	return true
end

function FighterInBattle:setVisible(temp)
	return({"setVisible"})
end

-- function FighterInBattle:recoveryFromAttack( time )
-- 	--从挨打中恢复
-- 	-- print(self.fighterName,"recover from attack")
-- 	if  (self.buffAddon.Freeze or self.buffAddon.Stun or self.fighterState.Dead) then
-- 		return false
-- 	end
-- 	self.battleField:addPlay( time, self.playNormal, {self, time} )
-- 	return true
-- end

function FighterInBattle:addBuff( receiver, addType, time )
	--加buff
	-- print("buff is called")
	if receiver.fighterState.Dead then
		return false
	end
	-- print("Add Buff!",self.fighter.Information.Name," to ", receiver.fighter.Information.Name)
	local buffs
	-- 判断要放的是哪个 BUFF
	if addType == "toSelf" then 
		-- print (self.fighter.Information.Name,"manage to buff himself")
		if self.skillState.LastSkill == "Normal" then 
			buffs = self.fighter.NormalAtk.EffectToC.Buffs
			-- print("Normal to C")
		else
			buffs = self.fighter.SuperAtk.EffectToC.Buffs
			-- print("Normal to R")
		end
	else 
		if self.skillState.LastSkill == "Normal" then 
			buffs = self.fighter.NormalAtk.EffectToR.Buffs
			-- print("Super to C")
		else
			buffs = self.fighter.SuperAtk.EffectToR.Buffs
			-- print("Super to R")
		end
	end

	if (not buffs.IsGoodBuff) and (receiver.buffAddon.Invincible or receiver.buffAddon.Immune) then
		-- print("immune bad buffs")
		return false
	end

	for k,v in pairs(buffs) do
		-- 计算 BUFF 添加成功率
		local possibility = Formulas.getBuffSuccessPossibility(v, self, receiver)
		if k == "Stun" then 
				-- print(self.fighterName, "manage to add buff to", receiver.fighterName)
				-- print(possibility, "% success")
			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Stun + receiver.giftAddon.Resists + receiver.captainAddon.ResistStun + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistStun + receiver.equipmentsAddon.ResistStun, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
		elseif k == "Freeze" then 
			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Freeze + receiver.giftAddon.Resists + receiver.captainAddon.ResistFreeze + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistFreeze + receiver.equipmentsAddon.ResistFreeze, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
		elseif k == "Disarm" then 
			possibility = possibility * 100 / (100 + receiver.fighter.Resistance.Disarm + receiver.giftAddon.Resists + receiver.captainAddon.ResistDisarm + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistDisarm + receiver.equipmentsAddon.ResistDisarm, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
		end

		-- print("attempt to add buff:",k,"p=",possibility,"from",self.fighter.Information.Name,"to",receiver.fighter.Information.Name)
		if possibility >= Functions.RandomBetweenLowAndUp(0,100) then
			-- print("add success")
			-- 如果已经有同一人放的同一技能带来的同种效果则覆盖掉旧的效果
			for l,m in pairs(receiver.currentBuffs) do
				if l.fighter and l.fighter == self and l.normalOrSuper == self.skillState.LastSkill and l.buffType == k then 
					-- 去除掉旧效果的影响
					if type(m.target[l.buffType]) == "boolean" then 
						m.target[l.buffType] = false
					else
						m.target[l.buffType] = m.target[l.buffType] - m.value 
						if l.buffType == "Hp" then
							local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
							local hpDifference = updatedTotalHp - receiver.totalHp
							receiver:changeCurrentHpBy(hpDifference, time, false, "total")
						end
					end
					receiver.currentBuffs[l] = nil
					break
				end
				--remove bad buffs
				if k == "Remove" and m.IsGoodBuff == false then
					print("Remove:" ,l.buffType, "added from:", l.fighter.fighterName, "of:", receiver.fighterName)
					-- print(m.IsGoodBuff)
					if type(m.target[l.buffType]) == "boolean" then 
						m.target[l.buffType] = false
					else
						m.target[l.buffType] = m.target[l.buffType] - m.value 
						if l.buffType == "Hp" then
							local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
							local hpDifference = updatedTotalHp - receiver.totalHp
							receiver:changeCurrentHpBy(hpDifference, time, false, "total")
						end
					end
					receiver.currentBuffs[l] = nil
				end
			end
			if k == "Remove" then
				print("Remove bad buffs")
			else
				-- 生成 BUFF
				local buffkey = {
					fighter = self,
					normalOrSuper = self.skillState.LastSkill,
					buffType = k,
				}
				local buffvalue = {
					value = v.BaseNumber + self.fighterLvl * v.DeltaNumber,
					time = math.floor(v.BaseTime + self.fighterLvl * v.DeltaTime),
					IsGoodBuff = v.IsGoodBuff
				}
				-- 攻击 防御 改变要根据具体攻击力和防御力来计算 毒和流血要计算抗性
				-- if k == "Atk" then 
				-- 	buffvalue.value = receiver.baseAttack * buffvalue.value / 100
				-- elseif k == "Def" then 
				-- 	buffvalue.value = receiver.baseDefence * buffvalue.value / 100
				if k == "Poison" then 
					buffvalue.value = buffvalue.value * 100 / (100 + receiver.fighter.Resistance.Poison + receiver.giftAddon.Resists + receiver.captainAddon.ResistPoison + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistPoison + receiver.equipmentsAddon.ResistPoison, receiver.fighterLvl, receiver.fighterStar, "Resists")) 	
				elseif k == "Bleeding" then 
					buffvalue.value = buffvalue.value * 100 / (100 + receiver.fighter.Resistance.Bleeding + receiver.giftAddon.Resists + receiver.captainAddon.ResistBleeding + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistBleeding + receiver.equipmentsAddon.ResistBleeding, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
				elseif k == "Burning" then
					buffvalue.value = buffvalue.value * 100 / (100 + receiver.fighter.Resistance.Burning + receiver.giftAddon.Resists + receiver.captainAddon.ResistBurning + Formulas.convertRatingToPercentage(receiver.buffAddon.ResistBurning + receiver.equipmentsAddon.ResistBurning, receiver.fighterLvl, receiver.fighterStar, "Resists")) 
				end
				-- 记录 BUFF 在施放对象中的效果对应表以方便索引
				buffvalue.target = receiver.buffAddon
				-- 添加新效果的影响
				if type(buffvalue.target[k]) == "boolean" then 
					buffvalue.target[k] = true
					-- print("boolean buff")
				else
					if k == "Hp" or k == "Atk" or k == "Def" then
						buffvalue.value = buffvalue.value * Macros.STARCOEFFCIENT ^ (self.fighterStar - 1)
					end
					print(k, buffvalue.target[k], buffvalue.value)
					buffvalue.target[k] = buffvalue.target[k] + buffvalue.value
					if k == "Hp" then
						-- print ("add hp buff")
						local updatedTotalHp = Formulas.getHp(receiver.calculatingParams)
						local hpDifference = updatedTotalHp - receiver.totalHp
						receiver:changeCurrentHpBy(hpDifference, time, false, "total")
						-- receiver.battleField:addProcess( time, receiver.changeCurrentHpBy, {receiver, buffvalue.value, time, false, "total"})
					end
					-- print("value buff")
				end
				-- 挂上 BUFF
				receiver.currentBuffs[buffkey] = buffvalue
				buffkey = "{fighter = self,normalOrSuper=\'"..buffkey.normalOrSuper.."\',buffType=\'"..buffkey.buffType.."\'}"

				receiver.battleField:addPlay( time , receiver.playAddBuffAnimation, {receiver, buffkey, time} )
			end
		end
		return true
	end
end

function FighterInBattle:dealBuffEffect(bufftype, time)
	local value, killed = self:changeCurrentHpBy(self.buffAddon[bufftype], time)
	if value < 0 then
		self.statManager:receiveDamage(-value)
	end
	local totalvalue = 0
	local valuetable = {}
	for k,v in pairs(self.currentBuffs) do
		if k.fighter then
			if k.buffType == bufftype then
				totalvalue = totalvalue + v.value
				valuetable[k.fighter] = v.value
				if killed then
					k.fighter.statManager:killEnemy(self)
				end
			end
		end
	end
	for k,v in pairs(valuetable) do
		-- print("i am wondering if this block will be executed")
		local valueToMake = v*value/totalvalue
		if valueToMake < 0 then
			valueToMake = -valueToMake
		end
		k.statManager:buffsMadeByValue(bufftype, valueToMake)
	end
end

function FighterInBattle:removeBuff( buffkey, time )
	--移除buff
	if self.fighterState.Dead then
		return false
	end
	-- print (self.fighter.Information.Name,buffkey.buffType,"from",buffkey.fighterName,"removed")
	if type(self.currentBuffs[buffkey].target[buffkey.buffType]) == "boolean" then 
		self.currentBuffs[buffkey].target[buffkey.buffType] = false
	else
		self.currentBuffs[buffkey].target[buffkey.buffType] = self.currentBuffs[buffkey].target[buffkey.buffType] - self.currentBuffs[buffkey].value 
		if buffkey.buffType == "Hp" then
			local updatedTotalHp = Formulas.getHp(self.calculatingParams)
			local hpDifference = updatedTotalHp - self.totalHp
			self:changeCurrentHpBy(hpDifference, time, false, "total")
			-- self.battleField:addProcess( time, self.changeCurrentHpBy, {self, - self.currentBuffs[buffkey].value, time, false, "total"})
		end
	end
	self.currentBuffs[buffkey] = nil
	buffkey = "{fighter = self,normalOrSuper=\'"..buffkey.normalOrSuper.."\',buffType=\'"..buffkey.buffType.."\'}"
	self.battleField:addPlay( time , self.playRemoveBuffAnimation, {self, buffkey, time} )
	return true
end

function FighterInBattle:changeCurrentHpBy( hp, time, isCritical, type )
	local killed = false
	--减血事件，死人和位移中的人不减血
	if self.fighterState.Dead then
		return {"changeCurrentHpBy",0}
	end
	if self.fighterState.InDisplace then
		return {"changeCurrentHpBy",false}
	end
	local hpTemp
	local hpToChange
	if type ~="total" then --正常加减血
		hpTemp = hp
		if self.buffAddon.Invincible and hpTemp < 0 then
       			hpTemp = -Macros.Epsilon--一个小量，用来判断0血是加血还是减血造成
    		end
		if self.currentHp + hpTemp > self.totalHp then
			hpTemp = self.totalHp - self.currentHp
		elseif self.currentHp + hpTemp <= 0 then
			if type == "nonlethal" then --不至死
				hpTemp = - self.currentHp + 1 - Macros.Epsilon
			else
				hpTemp = - self.currentHp - Macros.Epsilon
				self.battleField:addProcess( time + Macros.DeathDelay, self.death, {self, time + Macros.DeathDelay} )
				killed = true
			end
		end
		hpToChange = Functions.getInteger(hpTemp)
		self.currentHp = self.currentHp + hpToChange
		if (self.isFriend and hpTemp >=0) or ((not self.isFriend) and hpTemp < 0) then
			-- self.battleField.comboManager:addCombo("value",time)
			print("self.battleField:addPlay")
			-- self.battleField:addPlay(time, self.battleField.comboManager.addCombo, {self.battleField.comboManager, "display", time})
		end
		if hp == -Macros.KnockOutValue then
			self.battleField:addPlay( time, self.playHpChangeAnimation, {self, self.totalHp, self.currentHp, -Macros.KnockOutValue, isCritical, type, time} )
		else
			self.battleField:addPlay( time, self.playHpChangeAnimation, {self, self.totalHp, self.currentHp, hpTemp, isCritical, type, time} )
		end
	else --上限加减血
		hpTemp = Functions.getInteger(hp)
		if hpTemp > 0 then
			self.totalHp = self.totalHp + hpTemp
			self.currentHp = self.currentHp + hpTemp
		elseif hpTemp + self.totalHp <= 0 then
			self.totalHp = Macros.Epsilon
			self.currentHp = 0
			self.battleField:addProcess( time + Macros.DeathDelay, self.death, {self, time + Macros.DeathDelay} )
		else
			self.totalHp = self.totalHp + hpTemp
			if self.currentHp > self.totalHp then
				self.currentHp = self.totalHp
			end
		end
		hpToChange = hpTemp
		self.battleField:addPlay( time, self.playHpChangeAnimation, {self, self.totalHp, self.currentHp, hpToChange, isCritical, type, time} )
		self.calculatingParams.currentHp = self.currentHp
		self.calculatingParams.totalHp = self.totalHp
	end
	-- print(self.fighter.Information.Name,self.currentHp,self.totalHp)

	if (not (self.buffAddon.Invincible or self.buffAddon.Freeze or self.buffAddon.Stun or self.fighterState.Dead or type == "total")) and hpTemp < 0 then
		self.battleField:addPlay( time, self.playUnderAttack, {self, time, isCritical} )
		-- local underAttackTime = self.fighter.Skeleton.actions.smitten[2]/30
		-- self.battleField:addProcess( time + underAttackTime, self.recoveryFromAttack, {self, time + underAttackTime} )
	end
	print("hpToChange",hpToChange)
	return {"changeCurrentHpBy", hpToChange, killed}
end

--队长技，被动技
function FighterInBattle:addOrRemoveCaptainBuff( captainfighter, addorremove, time )
	--队长技
	--移除时的显示效果？血量和光环的区别？
	local lseffectivetotype = captainfighter.LeaderSkill.EffectiveToType
	local lseffect = captainfighter.LeaderSkill.Effect
	for typek,typev in pairs(lseffectivetotype) do
		if self.fighterType == typev or self.fighter.Information.Profession == typev then
			for effectk,effectv in pairs(lseffect) do
				if addorremove == "Add" then 
					self.captainAddon[effectk] = self.captainAddon[effectk] + effectv
					-- self.battleField:addPlay( time , self.playAddBuffAnimation, {self, {iscaptain = true, bufftype = effectk, buffvalue = effectv}, time} )
				else
					self.captainAddon[effectk] = self.captainAddon[effectk] - effectv
				end
			end
		end
	end
	if time then
		self:refreshTotalHp(time)
	end
end

function FighterInBattle:refreshFeverBuff( feverBuff, time )
	local fevereffecttype = feverBuff.object
	local fevereffect = feverBuff.aura
	for effectk,effectv in pairs(self.feverAddon) do
			self.feverAddon[effectk] = 0
	end
	for typek,typev in pairs(fevereffecttype) do
		if self.fighterType == typev or self.fighter.Information.Profession == typev then
			for effectk,effectv in pairs(fevereffect) do
				-- print ("fever to fighter", effectk, effectv)
				self.feverAddon[effectk] = effectv
			end
		end
	end
	if time then
		self:refreshTotalHp(time)
	end
end

function FighterInBattle:refreshTotalHp(time)
	local updatedTotalHp = Formulas.getHp(self.calculatingParams)
	local hpDifference = updatedTotalHp - self.totalHp
	if hpDifference ~= 0 then
		self:changeCurrentHpBy(hpDifference, time, false, "total")
	end
end

--构造函数与初始化
function FighterInBattle:ctor(  )
	-- print("hello Fighter!")
	-- FighterInformation{
	self.isCaptain = false

	self.fighterState = {
		UnderAttack=false, Moved=false, Dead=false, InDisplace = false,
	}
	self.skillState = {
		LastSkill = "Normal", CoolDown=9999, IsReadyToCastSuper=false, NextSkillPriority=0,
		LastBoxNumber=0, ReceiverInfo={}, LifeSteal=false, LifeStealRatio=0, IsCasted=false,
		-- Critical = false, 
	}
	self.buffAddon = {
		Miss = 0, Hp=0, Atk=0, Def=0, CriP=0, CriV=0, MoveAbility=0, MovePreference=0,
		ResistStun=0, ResistFreeze=0, ResistDisarm=0, ResistBleeding=0, ResistCriticalDamage=0, ResistPoison = 0,
		ResistBurning = 0,
		HitRate = 0, DamageRebound = 0,
		Stun=false, Freeze=false, Disarm=false, Burning = 0, Poison=0, Bleeding=0, Chaos = false,-- debuffs
		ContinuingHeal=0, Immune=false, Invincible=false, ActTwice = false, CounterAttack=false,-- buffs
	}
	-- self.itemBuffs = {
	-- 	Miss = 0, Hp=0, Atk=0, Def=0, CriP=0, CriV=0, MoveAbility=0, MovePreference=0,
	-- 	ResistStun=0, ResistFreeze=0, ResistDisarm=0, ResistBleeding=0, ResistCriticalDamage=0,
	-- 	HitRate = 0,
	-- 	Stun=false, Freeze=false, Disarm=false, Poison=0, Bleeding=0, -- debuffs
	-- 	ContinuingHeal=0, ActTwice=false, Immune=false, CounterAttack=false, Invincible=false, -- buffs
	-- }
	self.currentBuffs = { -- 当前角色身上的buff列表
		--{fighterName, normalOrSuper, buffType} = {value, time, target, isgood},
	}
	self.captainAddon = {
		Atk=0, Def=0, Hp=0, CriP=0, CriV=0, Miss=0, HitRate = 0, 
		ResistStun=0, ResistDisarm=0, ResistFreeze=0, ResistPoison=0, ResistBleeding=0, ResistCriticalDamage=0, ResistBurning = 0,
	}
	self.feverAddon = {
		Atk=0, Def=0, Hp=0, CriP=0, CriV=0, Miss=0, HitRate = 0,
		ResistStun=0, ResistDisarm=0, ResistFreeze=0, ResistPoison=0, ResistBleeding=0, ResistCriticalDamage=0, ResistBurning = 0,
	}
end

local function putOnEquipment(self, fighterinformation, equip)
	if fighterinformation.Fighter[equip] then
		self[equip] = require("app/data/Equipments/"..fighterinformation.Fighter[equip])
		for k,v in pairs(self.equipmentsAddon) do
			self.equipmentsAddon[k] = v + self[equip][k]
			-- print(self.fighterName..k,"now",self.equipmentsAddon[k])
		end
	else
		-- print ("this character has no "..equip)
	end
end

local function addGift(self, gift)
	-- print("add gift!")
	for k,v in pairs(gift) do
		self.giftAddon[k] = self.giftAddon[k] + v
	end
end

local function initEquipmentsAndGift(self, fighterinformation)
	--初始化装备
	self.equipmentsAddon = {
		--三围
		Hp = 0,
		Atk = 0,
		Def = 0,
		CriPRating = 0, -- 暴击等级
		CriVRating = 0, -- 暴伤等级
		MissRating = 0, -- 闪避等级
		--抗性等级
		ResistStun = 0,
		ResistDisarm = 0,
		ResistFreeze = 0,
		ResistPoison = 0,
		ResistBurning = 0,
		ResistBleeding = 0,
		ResistCriticalDamage = 0,
	}

	putOnEquipment(self, fighterinformation, "Weapon")
	putOnEquipment(self, fighterinformation, "Head")
	putOnEquipment(self, fighterinformation, "Shoes")
	putOnEquipment(self, fighterinformation, "Armor")

	--初始化天赋
	self.giftAddon = {
		Hp = 0,
		Atk = 0,
		Def = 0,
		CriP = 0, 
		CriV = 0, 
		Miss = 0, 
		Resists = 0,
	}
	self.fighterType = fighterinformation.Fighter.Gift[1]
	if Functions.belongsToTable(self.fighterType, Tables.Gifts) then
		for i=2,6 do
			 if fighterinformation.Fighter.Gift[i] == 1 or fighterinformation.Fighter.Gift[i] == 2 then
			 	addGift(self, Tables.GiftInformation[self.fighterType][i-1][fighterinformation.Fighter.Gift[i]])
			 else
			 	-- print(self.fighter.Information.Name,"Gift level",i-1,"not decided yet")
			 end
		end
		self.captainAddon.Hp = self.captainAddon.Hp + self.giftAddon.Hp
		self.captainAddon.Atk = self.captainAddon.Atk + self.giftAddon.Atk
		self.captainAddon.Def = self.captainAddon.Def + self.giftAddon.Def
	else
		-- print ("invalid fighter type or fighter type has not decided")
	end
end

function FighterInBattle:initWithFighterInformation( fighterinformation, isfriend, battlefield )
	self.battleField = battlefield
	self.fighterName = fighterinformation.Fighter.Name
	self.fighterLvl = fighterinformation.Fighter.Level
	self.fighterStar = fighterinformation.Fighter.Star
	self.fighterColour = fighterinformation.Fighter.Colour
	-- 怪物携带的物品 by Yi Feng
	self.droppedItem = fighterinformation.Fighter.Item
	self.isFriend = isfriend
	print("isfriend-------------------",isfriend)
	print (self.fighterName)
	self.fighter = require (self.fighterName)

	initEquipmentsAndGift(self, fighterinformation)
	-- added by Yi 
	--self.type = "cocostudio"
	-- self.type = "spine"
 --    if self.type == "cocostudio" then 
 --    	-- cocostudio
	-- 	local manager = CCArmatureDataManager:sharedArmatureDataManager()
	-- 	-- manager:addArmatureFileInfo("knight.png", "knight.plist", "knight.xml")
	-- 	manager:addArmatureFileInfo("tauren0.png", "tauren0.plist", "tauren.ExportJson")
	-- 	if self.isFriend then
	-- 		self.armature = CCArmature:create("tauren")
	-- 		self:addChild(self.armature)
	-- 		-- self:setScaleX(0.5)
	-- 		-- self:setScaleY(0.5)
	-- 		self.armature:getAnimation():play("loading")
	-- 	else 
	-- 		self.armature = CCArmature:create("tauren")
	-- 		self:addChild(self.armature)
	-- 		self:setScaleX(-1)
	-- 		-- self:setScaleY(0.5)
	-- 		self.armature:getAnimation():play("loading")
	-- 	end
	-- 	self.armature:setAnchorPoint(ccp(0.5,0.5))
 --    else 
 --    	--spine
 --    	-- if self.isFriend then
 --    	-- print("friend")
	-- 	self.armature = SkeletonManager.create(self.fighter.Skeleton)
	-- 	self:addChild(self.armature)
	-- 	self.armature:setPosition(ccp(0, -120))
	-- 	self.dandao = SkeletonManager.createDandao(self.fighter.Skeleton)
	-- 	self:addChild(self.dandao)
	-- 	self.dandao:setPosition(ccp(0, -120))
	-- 	SkeletonManager.kongdandao(self.dandao)
	-- 	-- self.armature:setScaleY(1)
	-- 	if self.isFriend then
	-- 		self.armature:setScaleX(-1)
	-- 		self.dandao:setScaleX(-1)
	-- 	-- else
	-- 	-- 	self.armature:setScaleX(0.5)
	-- 	end
	-- 	SkeletonManager.idle(self.armature,self.fighter.Skeleton)
		--self.armature:getAnimation():play("loading")
	    -- else 
	 --    print("enemy")
		-- self.armature = SkeletonManager.create(self.fighter.Skeleton)
		-- self:addChild(self.armature)
		-- self.armature:setPosition(ccp(0, -120))
		-- self.armature:setScale(0.5)
		-- SkeletonManager.idle(self.armature,self.fighter.Skeleton)
		-- --self.armature:getAnimation():play("loading")
	    -- end
    -- end

	
	-- 基本三围初始化 方便后面用
	self.baseValues = {
		Atk = Formulas.getBaseAtkOfFighter(self.fighter.Ability, self.fighterStar, self.fighterLvl),
		Def = Formulas.getBaseDefOfFighter(self.fighter.Ability, self.fighterStar, self.fighterLvl),
		Hp = Formulas.getBaseHpOfFighter(self.fighter.Ability, self.fighterStar, self.fighterLvl),
		Miss = Formulas.getBaseMissOfFighter(self.fighter.Ability, self.fighterStar, self.fighterLvl),
		MoveAbility = {Friend = self.fighter.Ability.MoveFriend, Enemy = self.fighter.Ability.MoveEnemy,
						Preference = self.fighter.Ability.MovePreference},
		ResistStun = self.fighter.Resistance.Stun,
		ResistDisarm = self.fighter.Resistance.Disarm,
		ResistFreeze = self.fighter.Resistance.Freeze,
		ResistPoison = self.fighter.Resistance.Poison,
		ResistBurning = self.fighter.Resistance.Burning,
		ResistBleeding = self.fighter.Resistance.Bleeding,
		ResistCriticalDamage = self.fighter.Resistance.CriticalDamage,
		CriP = 0,
		CriV = 0,
	}

	self.calculatingParams = {
		base = self.baseValues,
		buff = self.buffAddon,
		captain = self.captainAddon,
		fever = self.feverAddon,
		equipment = self.equipmentsAddon,
		gift = self.giftAddon,
		level = self.fighterLvl,
		star = self.fighterStar,
		gifttype = self.fighterType,
		currenthp = self.currentHp,
		totalhp = self.totalHp
	}

	self.totalHp = Formulas.getHp(self.calculatingParams)
	self.currentHp = self.totalHp
	
	self.skillState.NextSkillPriority = self.fighter.NormalAtk.Speed
	self.skillState.CoolDown = self.fighter.SuperAtk.CD
	self.skillToCast = self.fighter.NormalAtk

	-- self.hpbar = F_HpBar.new({
	-- 		top = "hptest_top.png",
	-- 		-- bottom = "hptest_bottom.png",
	-- 		mid = "hptest_mid.png",
	-- 		x = 0,
	-- 		y = 125,
	-- 		midspeed = 100,
	-- 		})
 --    self.hpbar:setScaleX(2)
 --    self:addChild(self.hpbar,100000)

    -- self.hpbar2 = display.newSprite("hptest_bottom.png",0,125)
    -- self:addChild(self.hpbar2,100001)

    -- self.nameBox = CCLabelTTF:create(self.fighter.Information.Name, "Arial", 40)
    -- self.nameBox:setColor(ccc3(0,0,0))
    -- self.nameBox:setPosition(ccp(0,160))
    -- self:addChild(self.nameBox,100000)

    self.notacted = true
    self.isboss = false
    self.statManager = StatManager.new(self)
    print("statManager established",self.statManager)
end


return FighterInBattle