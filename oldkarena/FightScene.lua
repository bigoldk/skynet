--
-- Author: Yiran WANG

--Mark 关于己方移动时的用户体验问题：
--    1、晕眩和定身时能否拖动，拖动时播放什么样的动画？
--    2、走出行动范围是否要停止走路动画？  

local class = require "class"                          

local FightScene = class("FightScene")
local Macros = require "Macros"
local GameStatus = require "GameStatus"
-- local FightBox = import("..layers.FightBox")
local Functions = require "Functions"
local Tables = require "Tables"
local FighterInBattle = require "FighterInBattle"
-- local F_FeverBar = import("..ui.F_FeverBar")
-- local F_InformationBox = import("..ui.F_InformationBox")
-- local F_SuperSkill = import("..ui.F_SuperSkill")
local Formulas = require "Formulas"
local ComboManager = require "ComboManager"
-- local MusicManager = import("..utils.MusicManager")
-- local F_ComboLabel = import("..ui.F_ComboLabel")
local BattleRatingSystem = require "BattleRatingSystem"
-- local F_GameEndLose = import("..ui.F_GameEndLose")
-- local F_GameEndWin = import("..ui.F_GameEndWinNew")
-- local F_Pause = import("..ui.F_Pause")
-- local SkeletonManager = import("..utils.SkeletonManager")
-- local Skeletons = import("..data.Skeletons")
-- local F_ItemBoxNew = import("..layers.F_ItemBox")
-- local TestSettings = import("..utils.TestSettings")
-- local Actions = require "Actions"
local CURRENT_MODULE_NAME = ...
-- local ItemEffect = import("..layers.ItemEffect")
--构造函数
function FightScene:ctor()
	--新建一个Scene，并且加一个layer。用关卡序号初始化信息
	-- MusicManager.new(self,"anhao.mp3")
	-- self.layer = display.newLayer()
	-- self:addChild(self.layer)
	-- self.battle_index = battle_index
	--init传入1-1关，之前初始化内容需要重新写
	-- print("battle_index =",battle_index)
	-- self.itemlist = itemlist 
	-- print("the list =",itemlist)
	self:init(1,battle_index)
	-- self.freeDrag = true
	self.currentWaitTime = 0
end
--初始化

local function dump(obj)
    local getIndent, quoteStr, wrapKey, wrapVal, dumpObj
    getIndent = function(level)
        return string.rep("\t", level)
    end
    quoteStr = function(str)
        return '"' .. string.gsub(str, '"', '\\"') .. '"'
    end
    wrapKey = function(val)
        if type(val) == "number" then
            return "[" .. val .. "]"
        elseif type(val) == "string" then
            return "[" .. quoteStr(val) .. "]"
        else
            return "[" .. tostring(val) .. "]"
        end
    end
    wrapVal = function(val, level)
        if type(val) == "table" then
            return dumpObj(val, level)
        elseif type(val) == "number" then
            return val
        elseif type(val) == "string" then
            return quoteStr(val)
        else
            return tostring(val)
        end
    end
    dumpObj = function(obj, level)
        if type(obj) ~= "table" then
            return wrapVal(obj)
        end
        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"
        for k, v in pairs(obj) do
            tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
        end
        tokens[#tokens + 1] = getIndent(level - 1) .. "}"
        return table.concat(tokens, "\n")
    end
    return dumpObj(obj, 0)
end



local function transformPoint( x, y, direction )
	-- local xOut, yOut, zOut
	-- if direction == "direct" then
	--             xOut = 0.9346*x-0.1530*y+33.2635
	--             yOut = 0.8512*y+17.0924
	--             zOut = -0.0003*y+1
	--             xOut = xOut/zOut
	--             yOut = yOut/zOut
	-- elseif direction == "inverse" then
	--             xOut = 1.076423632830687*x+0.179813943200664*y-38.879089910220530
	--             yOut = 1.174856*y-20.0811
	--             zOut = 0.000352*y+1
	--             xOut = xOut/zOut
	--             yOut = yOut/zOut 
	-- else
	--             return "transform_Wrong"
	-- end
	-- return xOut,yOut
	return x,y
end


function FightScene:executePlayList( dt )
	print("fightscene:executeplaylist")
		--用于在相应时间播放展示列表中相应内容
	while (self.playList[self.playCount] and self.playList[self.playCount][1] < self.gameTime - self.castStartTime) do
		local waitTime = self.playList[self.playCount][2](unpack( self.playList[self.playCount][3]))
		if type(waitTime) ~= "number" then
			waitTime = 0
		end
		if self.gameTime + waitTime > self.currentWaitTime then
			self.currentWaitTime = self.gameTime + waitTime
		end
		-- print("func :",self.playList[self.playCount][2])
		-- print("gametime",self.gameTime)
		-- print("castStartTime",self.castStartTime)
		-- print("time :",self.playList[self.playCount][1])
		-- print("processCount",self.playCount)
		self.playCount = self.playCount + 1

		
	end
	if self.scheduleExecutePlayList then
		if not self.playList[self.playCount] and self.currentWaitTime < self.gameTime then
			self:resetCastStatus()
			self.scheduler:unscheduleScriptEntry(self.scheduleExecutePlayList)
			self.scheduleExecutePlayList = nil
			-- print("switch to enemymove")
			self:switchToStatus(Macros.BattleStatus.kEnemyMove)
			self.currentWaitTime = 0
		end
	else
		if not self.playList[self.playCount]then
			self:resetCastStatus()
			self.scheduleExecutePlayList = nil
		end
	end
end

function FightScene:resetListStatus( )
	--重置展示与计算列表
	self.playCount = 1
	self.processList = nil
	self.processList = {}
	self.playList = nil
	self.playList = {}
	self.processReturnList = nil
	self.processReturnList = {}
end
function FightScene:resetCastStatus(    )
	--重置放技能参数（放技能人员列表）
	self.casterCount = 1
	self.casterNumber = 0
	self.caster = nil
	self.layer:setTouchCaptureEnabled(true)
	if self.battleStatus == Macros.BattleStatus.kFriendMove then
		if self.gameStatus == Macros.GameStatus.kPlaying then
			self.comboManager:startTimer()
			self.fightUILayer:setVisible(true)
		else
			self.battleStatus = Macros.BattleStatus.kOther
			self:unscheduleUpdate()
			self:onGameFinished()
		end
	end 
	self:resetListStatus()
end
function FightScene:switchToStatus( switchTo )
	-- 切换战斗阶段
	-- print("switchto, ", switchTo)
	for rowindex, row in pairs(self.ground) do
		for columnindex, boxtype in pairs(row) do
		local checkbox = self:getFightBoxByCoordinate({columnindex, rowindex})
		if checkbox then 
			checkfighter = checkbox.currentFighter
			
			--如果队员不是冰冻或晕眩，恢复正常动画
			if checkfighter and not (checkfighter.buffAddon.Freeze or checkfighter.buffAddon.Stun) then 
				if checkfighter.type == "cocostudio" then
		           checkfighter.armature:getAnimation():play("loading")
                else
                -- 	if not checkfighter.isFriend then 
    	           -- SkeletonManager.idle(checkfighter.armature,Skeletons.zhubajie)
    	           --  else
    	            SkeletonManager.idle(checkfighter.armature,checkfighter.fighter.Skeleton)
    	            -- end
                end
			end
		end
		end
	end
	self.battleStatus = switchTo
	if switchTo == Macros.BattleStatus.kFriendMove then
		self.comboManager:startTimer()
		--self.informationBox:refreshState()
		if TestSettings.SuperSkillType == 1 then
			self.SuperSkillBox:refreshState()
		else
			for i, currentfighter in ipairs(self.currentFighters["Friend"]) do
				if currentfighter.skillState.CoolDown == 0 then
					self.superSkillButton[i]:setButtonEnabled(true)
				else
					self.superSkillButton[i]:setButtonEnabled(false)
				end
			end
		end
		self.feverBar:setTouchCaptureEnabled(true)
		self:refreshFeverBuff()
	else
		self.feverBar:setTouchCaptureEnabled(false)
		self.comboManager:stopTimer()
	end
end
function FightScene:executeProcessList(  )
	--生成进程列表之后按顺序运行
	self.layer:setTouchCaptureEnabled(false)
	local processCount = 1
	while (self.processList[processCount]) do
		local vRet = self.processList[processCount][2](unpack( self.processList[processCount][3]))
		--将进程的返回值插入返回列表中
		print("hey there i am here!")
		table.insert(self.processReturnList, self.processList[processCount][4], vRet)
		-- print(self.processList[processCount][4],"的值为",vRet)
		-- print(self.processList[processCount][4],"的值为",self.processReturnList[self.processList[processCount][4]])
		processCount = processCount + 1
	-- print("processCountcalculate",processCount)
	end
end
function FightScene:executeCastSkill(  )
	-- print("execute cast skill")
	--完整的一套运行列表体系（释放正常技能，大招，包括以后可能的物品逻辑）
	-- self.fightUILayer:setVisible(false) -- 隐藏ui
	self:executeProcessList(  )
	--如果是在放技能阶段（正常技能），则结算CD时间。
	if self.battleStatus == Macros.BattleStatus.kCastSkills then
		for index, checkfighter in pairs(self.currentFighters["Enemy"]) do  
			--如果敌人CD没到，而且敌人有大招
			if checkfighter.skillState.CoolDown ~= 0 and checkfighter.fighter.SuperAtk.Name then 
				--如果还有一回合CD，那他下回合就准备放大。
				if checkfighter.skillState.CoolDown == 1 then
					-- print("tocast=super")
					checkfighter.skillState.IsReadyToCastSuper = true
				end
				--CD减1
				checkfighter.skillState.CoolDown = checkfighter.skillState.CoolDown - 1
			end
		end
		for index, checkfighter in pairs(self.currentFighters["Friend"]) do  
		--如果CD没到0，且有大招，CD减1
			if checkfighter.skillState.CoolDown ~= 0 and checkfighter.fighter.SuperAtk.Name then 
				checkfighter.skillState.CoolDown = checkfighter.skillState.CoolDown - 1
			end
		end
	end
	--设置放技能开始时间
	self.castStartTime = self.gameTime
	--调度执行播放列表的函数
	if not self.scheduleExecutePlayList then
		self.scheduleExecutePlayList = self.scheduler:scheduleScriptFunc(handler(self, self.executePlayList), 0.0167, false)
	end
end

function FightScene:onGameFinished(    )
	-- self.fightUILayer:setVisible(true)
	-- if self.gameStatus == Macros.GameStatus.kGameOver then
	-- 	local gamelose = F_GameEndLose.new(self):pos(display.width/2-self.originX,display.height/2-self.originY):addTo(self) 
	-- 	self.battleRatingSystem:rate()
	-- elseif self.gameStatus == Macros.GameStatus.kGameWin then
	-- 	local gamewin = F_GameEndWin.new(self):pos(display.width/2-self.originX,display.height/2-self.originY):addTo(self)
	-- 	self.battleRatingSystem:rate()
	-- end
	
end

function FightScene:init( chapterIndex, missionIndex)
	-- 初始化函数（许多成员函数都写成此函数的local变量）
	-- 调度函数记录变量
	self.scheduleExecutePlayList = nil
	local scheduleenemyappear = nil 
	local schedulebuffeffect = nil



	--场景切换事件
	-- local function onNodeEvent( event )
	-- 	if event.name == "enter" then
	-- 		-- 进入场景时设置3d投影模式
	-- 		--CCDirector:sharedDirector():setProjection(kCCDirectorProjection3D)
	-- 		-- print("SceneTestLayer1#onEnter")
	-- 	elseif event.name == "enterTransitionFinish" then

	-- 		-- local array = CCArray:create()
	-- 		-- array:addObject(CCMoveTo:create((920 - self.originX) / 400, ccp(940 - self.originX, 304)))
	-- 		-- array:addObject(CCMoveTo:create((320 - self.originX) / 400, ccp(620, 304)))
	-- 		-- local function onMoveFinished( sender )
	-- 		-- self:setTouchEnabled(true)

	-- 		--进入场景后再显示覆盖层，便于处理进场动画等
	-- 		self.fightEnemyLayer:setVisible(true)
	-- 		self.fightBoxLayer:setVisible(true)
	-- 		self.fightFriendLayer:setVisible(true)
	-- 		self.fightUILayer:setVisible(true)
	-- 		--self.pMenu:setVisible(true)

	-- 		--利用camera设置3d效果
	-- 		-- local camera = self.fightBoxLayer:getCamera()
	-- 		-- --self.fightBoxLayer:setAnchorPoint(CCPoint(0,0))
	-- 		-- local eyeX,eyeY,eyeZ = 0,0,0
	-- 		-- local centerX,centerY,centerZ = 0,0,0
	-- 		-- local upX,upY,upZ = 0,0,0
	-- 		-- eyeX,eyeY,eyeZ = camera:getEyeXYZ(eyeX,eyeY,eyeZ)
	-- 		-- centerX,centerY,centerZ = camera:getCenterXYZ(centerX,centerY,centerZ)
	-- 		-- upX,upY,upZ = camera:getUpXYZ(upX,upY,upZ )
	-- 		-- camera:setEyeXYZ(0,-3,15)
	-- 		-- camera:setCenterXYZ(0,0,0)
            
 --            --eyeX,eyeY,eyeZ = camera:getEyeXYZ(eyeX,eyeY,eyeZ)
	-- 		--centerX,centerY,centerZ = camera:getCenterXYZ(centerX,centerY,centerZ)
	-- 		--print("eye:",eyeX,eyeY,eyeZ,"center",centerX,centerY,centerZ,"up",upX,upY,upZ)
	-- 		-- _teamMenu->setVisible(true);
	-- 		-- end
	-- 		-- array:addObject(CCCallFuncN:create(onMoveFinished))
	-- 		-- local action = CCSequence:create(array)
	-- 		-- self:getChildByTag(Macros.BACKGROUND_TAG)
	-- 		-- self:getChildByTag(Macros.BACKGROUND_TAG):runAction(action)
	-- 		local function onTouch( event )
	-- 			-- 处理点击事件
	-- 			-- print("onTouch:",event, x[1],x[2],y[1],y[2])
	-- 			-- 用之前写过的变换函数把输入点做射影变换
	-- 			-- print("x=",event.x)
	-- 			-- print("y=",event.y)
	-- 			local pointTransformed = CCPoint(transformPoint( event.x,event.y, "direct" ))
	-- 			local touch = self:getFightBoxByTouchPoint(pointTransformed)
	-- 			if event.name == "began" then
	-- 				-- self.schedulelongtouch = self.scheduler:scheduleScriptFunc(handler(self,self.longtouch), 2, false)
	-- 				-- print("begin!")
	-- 				-- print("onTouchbegan:",event.x, event.y)
	-- 				-- print("transf direct",self:transformPoint( event.x,event.y, "direct" ))
	-- 				-- local xnew,ynew = self:transformPoint( event.x,event.y, "direct" )
	-- 				-- print("transf invers",self:transformPoint( xnew, ynew, "inverse" ))
	-- 				--点击时记录起始点位置，并且送给lstouch来处理点击事件

	-- 				self.beganPoint = CCPoint(event.x,event.y)
	-- 				originX,originY=self:getPosition() --获得参考坐标
	-- 				self:touchEventAction(touch, 0)
	-- 				return true
	-- 			elseif event.name == "moved" then 
	-- 				-- print("point moved")
	-- 				--同began
	-- 				self.movePoint = CCPoint(event.x,event.y)
	-- 				self.movePosition = 	
	-- 				self:touchEventAction(touch, 1)
	-- 				-- self.lsTouchHandler:sendTouchMessage(self, pointTransformed, 1)
	-- 			elseif event.name == "ended" then
	-- 				--点击结束时重置一些点击时产生的成员变量
	-- 				self:touchEventAction(touch, 2)
	-- 				-- self.lsTouchHandler:sendTouchMessage(self, pointTransformed, 2)
	-- 				self.movingBox = nil
	-- 				self.touchBeganBox = nil
	-- 				if self.dragSprite then 
	-- 					if self.dragSprite.type == "cocostudio" then
	-- 	                   self.dragSprite.armature:getAnimation():play("loading")
 --                        else
 --                        	-- if not self.dragSprite.isFriend then
 --    	                   -- SkeletonManager.idle(self.dragSprite.armature,Skeletons.zhubajie)
 --    	                   --  else 
 --    	                    	SkeletonManager.idle(self.dragSprite.armature,self.dragSprite.fighter.Skeleton)
 --    	                    -- end
 --                        end
	-- 					self.dragSprite = nil
	-- 				end
	-- 				if self.checkingEnemy then 
	-- 					self.checkingEnemy = nil
	-- 				end
	-- 			elseif event.name == "canceled" then
	-- 				self:touchEventAction(touch, 3)
	-- 				-- self.lsTouchHandler:sendTouchMessage(self, pointTransformed, 3)
	-- 				self.movingBox = nil
	-- 				self.touchBeganBox = nil
	-- 				if self.dragSprite then 
	-- 					if self.dragSprite.type == "cocostudio" then
	-- 	                   self.dragSprite.armature:getAnimation():play("loading")
 --                        else
 --                    --        if not self.dragSprite.isFriend then
 --    	               --     SkeletonManager.idle(self.dragSprite.armature,Skeletons.zhubajie)
 --    	               -- else
 --    	               	   SkeletonManager.idle(self.dragSprite.armature,self.dragSprite.fighter.Skeleton)
 --    	               	-- end
 --                        end
	-- 					self.dragSprite = nil
	-- 				end
	-- 				if self.checkingEnemy then 
	-- 					self.checkingEnemy = nil
	-- 				end
	-- 			end
	-- 		end
	-- 		--设置点击参数
	-- 		self.layer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	-- 		self.layer:setTouchEnabled(true)
	-- 		self.layer:setTouchCaptureEnabled(true)
	-- 		self.layer:setTouchSwallowEnabled(true)
	-- 		self.layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, onTouch)
	-- 	elseif event.name == "exit" then 
	-- 		-- exit here
	-- 		--退出场景时重置投影模式
	-- 		--CCDirector:sharedDirector():setProjection(kCCDirectorProjection2D)
	-- 	end
	-- end
	
	local function switchToEnemyAppear( dt )
		--调度函数，用于在敌人行动结束之后切换阶段
		self:switchToStatus(Macros.BattleStatus.kEnemyAppear)
		self.scheduler:unscheduleScriptEntry(scheduleenemyappear)
		scheduleenemyappear = nil
	end
	local function generateCasterList(    )
		--生成放技能人员列表，并且初始化进程列表
		-- print("generateCasterList", camp)
		self.caster = {}
		self.casterNumber = 0
		-- 根据敌我不同，初始化出手速度
		for index, checkfighter in pairs(self.currentFighters["Friend"]) do
			-- print("checkfighter.isfriend",checkfighter.isFriend)
			-- if (checkfighter.isFriend and camp == "Friend") or (not checkfighter.isFriend and camp == "Enemy") then 
			-- print("find one!")
			--乱敏
			if checkfighter.skillState.IsReadyToCastSuper then 
				checkfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(checkfighter.fighter.SuperAtk.Speed + 90, checkfighter.fighter.SuperAtk.Speed + 110)
			else 
				checkfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(checkfighter.fighter.NormalAtk.Speed + 90, checkfighter.fighter.NormalAtk.Speed + 110)
			end
			table.insert(self.caster, checkfighter)
			self.casterNumber = self.casterNumber + 1
			-- end
		end
		for index, checkfighter in pairs(self.currentFighters["Enemy"]) do
			-- print("checkfighter.isfriend",checkfighter.isFriend)
			-- if (checkfighter.isFriend and camp == "Friend") or (not checkfighter.isFriend and camp == "Enemy") then 
			-- print("find one!")
			if checkfighter.skillState.IsReadyToCastSuper then 
				checkfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(checkfighter.fighter.SuperAtk.Speed - 10, checkfighter.fighter.SuperAtk.Speed + 10)
			else 
				checkfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(checkfighter.fighter.NormalAtk.Speed - 10, checkfighter.fighter.NormalAtk.Speed + 10)
			end
			table.insert(self.caster, checkfighter)
			self.casterNumber = self.casterNumber + 1
			-- end
		end
		table.sort(self.caster, function ( a, b ) return a.skillState.NextSkillPriority > b.skillState.NextSkillPriority end)
		--下面是生成计算列表，根据出手速度算每个人的抬手时间，并且把抬手事件按时间顺序加入列表
		local highestPriority = self.caster[1].skillState.NextSkillPriority
		for k,v in pairs(self.caster) do
			local timeToCast = (highestPriority - v.skillState.NextSkillPriority) / 400
			-- print("timetocast:",timeToCast)
			self:addProcess(timeToCast, FighterInBattle.preCastSkill, {v, timeToCast})
		end
		-- self:executeProcessList()
	end
	local function buffEffect(    )
		--buff效果：就是处理加血减血，时间到了消buff
		-- print("buffeffect")
		for index, checkfighter in pairs(self.currentFighters["Friend"]) do
			if checkfighter.buffAddon.ContinuingHeal > 0 then
				self:addProcess(Macros.ContinuingHealEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "ContinuingHeal", Macros.ContinuingHealEffectTime})
			end
			if checkfighter.buffAddon.Poison < 0 then
				self:addProcess(Macros.PoisonEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Poison", Macros.PoisonEffectTime})
			end
			if checkfighter.buffAddon.Bleeding < 0 then
				self:addProcess(Macros.BleedingEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Bleeding", Macros.BleedingEffectTime})
			end
			if checkfighter.buffAddon.Burning < 0 then
				self:addProcess(Macros.BurningEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Burning", Macros.BurningEffectTime})
			end
			for buffkey,buff in pairs(checkfighter.currentBuffs) do
				-- print(checkfighter.fighter.Information.Name,"buff from",buffkey.fighterName,buff.time,"--")
				buff.time = buff.time - 1
				if buff.time == -1 then 
					self:addProcess(Macros.RemoveBuffEffectTime, FighterInBattle.removeBuff, {checkfighter, buffkey, Macros.RemoveBuffEffectTime})
				end
			end
		end
		for index, checkfighter in pairs(self.currentFighters["Enemy"]) do
			if checkfighter.buffAddon.ContinuingHeal > 0 then
				self:addProcess(Macros.ContinuingHealEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "ContinuingHeal", Macros.ContinuingHealEffectTime})
			end
			if checkfighter.buffAddon.Poison < 0 then
				self:addProcess(Macros.PoisonEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Poison", Macros.PoisonEffectTime})
			end
			if checkfighter.buffAddon.Bleeding < 0 then
				self:addProcess(Macros.BleedingEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Bleeding", Macros.BleedingEffectTime})
			end
			if checkfighter.buffAddon.Burning < 0 then
				self:addProcess(Macros.BurningEffectTime, FighterInBattle.dealBuffEffect, {checkfighter, "Burning", Macros.BurningEffectTime})
			end
			for buffkey,buff in pairs(checkfighter.currentBuffs) do
				if buffkey.buffType == "Stun" or buffkey.buffType == "Freeze" or buffkey.buffType == "Disarm" then
					buffkey.fighter.statManager:buffsMadeByTurns(buffkey.buffType)
				end
				-- print(checkfighter.fighter.Information.Name,"buff from",buffkey.fighterName,buff.time,"--")
				buff.time = buff.time - 1
				if buff.time == -1 then 
					self:addProcess(Macros.RemoveBuffEffectTime, FighterInBattle.removeBuff, {checkfighter, buffkey, Macros.RemoveBuffEffectTime})
				end
			end
		end
		self:executeProcessList()
	end
	local function playBuffEffect( dt )
		--展示buff效果
		while (self.playList[self.playCount] and self.playList[self.playCount][1] < self.gameTime - self.buffStartTime) do
			local waitTime = self.playList[self.playCount][2](unpack( self.playList[self.playCount][3]))
			if type(waitTime) ~= "number" then
				waitTime = 0
			end
			if self.gameTime + waitTime > self.currentWaitTime then
				self.currentWaitTime = self.gameTime + waitTime
			end
			self.playCount = self.playCount + 1
			-- print("processCount",self.playCount)
		end
		if not self.playList[self.playCount] and self.currentWaitTime < self.gameTime then
			self.currentWaitTime = 0
			self:resetListStatus()
			self.scheduler:unscheduleScriptEntry(schedulebuffeffect)
			schedulebuffeffect = nil
			self:switchToStatus(Macros.BattleStatus.kCastSkills)
		end
	end
	local function updateFighterStatus( camp )
		--做两件事情：1、按照y轴位置改变zorder以及透视大小 2、检测我方和敌方死亡人数，从而判断游戏是否结束
		-- for index, checkfighter in pairs(self.currentFighters[camp]) do  
		-- 	--设置zorder
		-- 	local _, checkfighterposy = checkfighter:getPosition()
		-- 	checkfighter:setZOrder(10000 - checkfighterposy)
		-- 	--设置透视关系大小
		-- 	local originScaleY = 0.5
		-- 	local originScaleX
		-- 	if checkfighter.chaosSwitch then
		-- 		originScaleX = -0.5
		-- 	else
		-- 		originScaleX = 0.5
		-- 	end
		-- 	-- if camp == "Enemy" then
		-- 	-- 	originScaleX = originScaleY
		-- 	-- else
		-- 	-- 	originScaleX = -originScaleY
		-- 	-- end
		-- 	checkfighter:setScaleX((1.1 - 0.2*checkfighterposy/480)*originScaleX)
		-- 	checkfighter:setScaleY((1.1 - 0.2*checkfighterposy/480)*originScaleY)
		-- end
		if self.fighterDead[camp] == self.totalFighterNumber[camp] and self.animationNumber == 0 then 
			if camp == "Friend" then 
				print("gameover : friends slayed")
				self.gameStatus = Macros.GameStatus.kGameOver
			elseif camp == "Enemy" then 
				print("gamewin : enemy slayed")
				self.gameStatus = Macros.GameStatus.kGameWin
			end
		end
	end
	local function addFighter( fighterToAdd, camp )
		--初始化的时候添加角色
		for _, currentfighter in pairs(self.currentFighters[camp]) do
			if currentfighter.isCaptain then 
			fighterToAdd:addOrRemoveCaptainBuff(currentfighter.fighter, "Add")
			end
		end
		table.insert(self.currentFighters[camp], fighterToAdd)
		if fighterToAdd.isCaptain then 
			for _, fightersinbattle in pairs(self.currentFighters[camp]) do
			fightersinbattle:addOrRemoveCaptainBuff(fighterToAdd.fighter, "Add")
			end
		end
		-- add field buff
		-- fighterToAdd:setVisible(true)
	end
	local function initFighters( camp )
		-- print("camp,",camp)
		-- print(camp)
		-- print(dump(self.fighterList[camp]))
		local i = 0
		
		--根据角色列表初始化场上角色
		for index, fighterinfo in pairs(self.fighterList[camp]) do
			i = i+1
			print("fighterindex",index)
			local fighterName = fighterinfo.Fighter.Name
			local fighterToAdd
			if Functions.belongsToTable(fighterName, Tables.FighterScripts) then
				print("scriptft",fighterName)
				local fighterScript = require (fighterName.."Script")
				print(fighterName.."Script here!!!")
				fighterToAdd = fighterScript.new()
			else
				fighterToAdd = FighterInBattle.new()
				-- print("it goes this way (else!!!)")
			end
			if camp == "Friend" then 
				fighterToAdd:initWithFighterInformation(fighterinfo, true, self)
			else 
				fighterToAdd:initWithFighterInformation(fighterinfo, false, self)
			end
				print("fjadlsfjkdsajfkljdaslfjldas",fighterName,dump(fighterToAdd.battleField))
			for _, captainindex in pairs(self.captainIndex[camp]) do
				if index == captainindex then 
					fighterToAdd.isCaptain = true
					break
				end
			end
			if fighterinfo.isboss == true then
				fighterToAdd.isboss = true
			end
			-- fighterToAdd:setVisible(false)
			--把第0回合的选手扔上场
			if fighterinfo.onStage == 0 then 
				-- print("add fighter :", camp)
				addFighter(fighterToAdd, camp)
				-- local toSetBox = self:getFightBoxByCoordinate(fighterinfo.initPos)
				-- self:setCharacterToPosition(toSetBox, fighterToAdd)
				if camp == "Friend" then
					fighterToAdd.startBox = toSetBox
				end
			end
			self.fighterList[camp][index]["onStage"] = self.fighterList[camp][index]["onStage"] -1 -- 表示已经添加过了
			table.insert(self.totalFighters[camp], fighterToAdd)
			-- self.fightFriendLayer:addChild(fighterToAdd, Macros.FriendZOrder)
		end
		print("totally there are ",i)
	end
	local function enemyMoveByOneBox( mover )
		--敌人移动一格（判断他下一步要去哪个格子，并且把他的数据放过去）
		local moveOver = false
		local curBox = mover.currentBox
		local curCor = curBox.coordinate
		-- print("move by one box:",curCor[1],curCor[2])
		if curCor[1] == Macros.FIGHTBOX_COLUMN then 
			-- print("gameover : move to end")
			self.gameStatus = Macros.GameStatus.kGameOver
			moveOver = true
		else
			local cannotmove = false
			if mover.buffAddon.Stun or mover.buffAddon.Freeze then
				cannotmove = true
			end
			if not cannotmove then
				local moveBy
				if mover.buffAddon.Chaos then
					moveBy = {-1, 0}
				else
					moveBy = {1, 0}
				end
				local toMovePos = curBox:getPosOfRelativeBox(moveBy)
				if toMovePos[1] == 0 then
					return true
				end
				print("to move pos:", mover.fighter.Information.Name, toMovePos[1],toMovePos[2])
				local toMove = self:getFightBoxByCoordinate(toMovePos)
				-- print("contenttype:",toMove.contentType, Macros.FIGHTBOX_ACCESSABLETYPE, toMove.currentFighter)
				if toMove.contentType < Macros.FIGHTBOX_ACCESSABLETYPE and not toMove.currentFighter then 
					-- print("can move directly")
					self:setCharacterDataToPosition(toMove, mover)
					curBox:setEmpty()
				elseif Formulas.getMovePreference(mover.calculatingParams) > 0 then 
					-- print("move pref",Formulas.getMovePreference(mover.calculatingParams))
					-- 这里可以拐弯 就一定会拐弯
					local canturnup = true
					local canturndown = true
					local moveUp = {0, 1}
					local moveDown = {0, -1}
					local toMoveUpPos = curBox:getPosOfRelativeBox(moveUp)
					local toMoveDownPos = curBox:getPosOfRelativeBox(moveDown)
					local toMoveUp = self:getFightBoxByCoordinate(toMoveUpPos)
					local toMoveDown = self:getFightBoxByCoordinate(toMoveDownPos)
					-- print("coordinate",curCor[1],curCor[2])
					if curCor[2] == self.minRow or toMoveDown.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE or toMoveDown.currentFighter then
						-- print("cant down") 
						canturndown = false
					end 
					if curCor[2] == self.maxRow or toMoveUp.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE or toMoveUp.currentFighter then 
						-- print("cant up") 
						canturnup = false
					end
					if canturnup and canturndown then 
						local random = Functions.RandomBetweenLowAndUp(0, 100)
						if random > 50 then 
							self:setCharacterDataToPosition(toMoveUp, mover)
							curBox:setEmpty()
						else
							self:setCharacterDataToPosition(toMoveDown, mover)
							curBox:setEmpty()
						end
					elseif canturnup then 
						self:setCharacterDataToPosition(toMoveUp, mover)
						curBox:setEmpty()
					elseif canturndown then 
						self:setCharacterDataToPosition(toMoveDown, mover)
						curBox:setEmpty()
					else
						moveOver = true
					end
				else
					moveOver = true
				end
			else
				moveOver = true
			end
		end
		return moveOver
	end
	local function enemyMove(    )
		--敌人移动
		-- print("ENEMY MOVE!")
		for index, checkfighter in pairs(self.currentFighters["Enemy"]) do
			local cannotmove = false
			if checkfighter.buffAddon.Stun or checkfighter.buffAddon.Freeze then
				cannotmove = true
			end
			if not cannotmove then 
				if checkfighter.type == "cocostudio" then
		           checkfighter.armature:getAnimation():play("run")
                else
            --        if not checkfighter.isFriend then
    	       --     SkeletonManager.run(checkfighter.armature,Skeletons.zhubajie)
    	       -- else
    	       	   SkeletonManager.run(checkfighter.armature,checkfighter.fighter.Skeleton)
    	       	-- end
                end
				-- mark 这里要改，代码重复了 与 enemymovebyonebox 
			end
			checkfighter.fighterState.Moved = false
		end
		for index, checkfighter in pairs(self.currentFighters["Friend"]) do
			if checkfighter.buffAddon.Chaos then
				local cannotmove = false
				if checkfighter.buffAddon.Stun or checkfighter.buffAddon.Freeze then
					cannotmove = true
				end
				if not cannotmove then 
					if checkfighter.type == "cocostudio" then
		    	       checkfighter.armature:getAnimation():play("run")
            	    else
            	--        if not checkfighter.isFriend then
    	    	   --     SkeletonManager.run(checkfighter.armature,Skeletons.zhubajie)
    	    	   -- else
    	    	   	   SkeletonManager.run(checkfighter.armature,checkfighter.fighter.Skeleton)
    	    	   	-- end
            	    end
					-- mark 这里要改，代码重复了 与 enemymovebyonebox 
				end
				checkfighter.fighterState.Moved = false
			end
		end
		for index, checkfighter in pairs(self.currentFighters["Enemy"]) do
			if not checkfighter.fighterState.Moved then 
				local moveover = false
				-- 按照行动力，一步一步走
				for k = 1, Formulas.getEnemyMoveAblilty(checkfighter.calculatingParams) do
					if enemyMoveByOneBox(checkfighter) then
						moveover = true
					break
					end
				end
				self:moveCharacterToCurrent(checkfighter)
				if checkfighter.currentBox.coordinate[1] > Macros.FIGHTBOX_MAX_ENEMY_COLUMN and checkfighter.statManager:getStat("finalPassLines") < checkfighter.currentBox.coordinate[1] - Macros.FIGHTBOX_MAX_ENEMY_COLUMN then
					 checkfighter.statManager:setFinalPassLines(checkfighter.currentBox.coordinate[1] - Macros.FIGHTBOX_MAX_ENEMY_COLUMN)
				end
				checkfighter.fighterState.Moved = true
			end
		end
		for index, checkfighter in pairs(self.currentFighters["Friend"]) do
			if checkfighter.buffAddon.Chaos and not checkfighter.fighterState.Moved then 
				local moveover = false
				-- 按照行动力，一步一步走
				for k = 1, Formulas.getEnemyMoveAblilty(checkfighter.calculatingParams) do
					if enemyMoveByOneBox(checkfighter) then
						moveover = true
					break
					end
				end
				self:moveCharacterToCurrent(checkfighter)
				if checkfighter.currentBox.coordinate[1] > Macros.FIGHTBOX_MAX_ENEMY_COLUMN and checkfighter.statManager:getStat("finalPassLines") < checkfighter.currentBox.coordinate[1] - Macros.FIGHTBOX_MAX_ENEMY_COLUMN then
					 checkfighter.statManager:setFinalPassLines(checkfighter.currentBox.coordinate[1] - Macros.FIGHTBOX_MAX_ENEMY_COLUMN)
				end
				checkfighter.fighterState.Moved = true
			end
		end
		scheduleenemyappear = self.scheduler:scheduleScriptFunc(switchToEnemyAppear, 0.5, false)
		-- self:schedule(switchToEnemyAppear, 1.0)
	end
	local function enemyAppear(    )
		--敌人出现
		for index, enemy in pairs(self.fighterList.Enemy) do
			-- print("enemy appear:", enemy[1],enemy[2],enemy[3],enemy[4],enemy[5])
			if enemy.onStage == 0 then -- 如果当前轮要出场
			-- print("Enemy about to appear")
			local checkbox = self:getFightBoxByCoordinate(enemy.initPos)
			if checkbox then 
				local checkfighter = checkbox.currentFighter
				if not checkfighter then 
					local fighterToAdd = self.totalFighters.Enemy[index]
					-- print("Add new fighter!", index, self.totalFighters.Enemy[index].fighter)
					self.fighterList.Enemy[index]["onStage"] = -1
					addFighter(fighterToAdd, "Enemy")
					-- print("After add the new fighter")
					self:setCharacterToPosition(checkbox, fighterToAdd)
				end
			end
			elseif enemy["onStage"] > 0 then 
				self.fighterList.Enemy[index]["onStage"] = self.fighterList.Enemy[index]["onStage"]-1
			end
		end
		-- print("Enemy appear, before switch to status")
		if self.gameStatus == Macros.GameStatus.kPlaying then
			self:switchToStatus(Macros.BattleStatus.kFriendMove)
			self.fightUILayer:setVisible(true)
		else
			self:unscheduleUpdate()
			self:onGameFinished()
		end
	end
	local function setFriendStartBox()
		for i = Macros.FIGHTBOX_MIN_FRIEND_COLUMN, Macros.FIGHTBOX_MAX_FRIEND_COLUMN do
			for j = self.minRow, self.maxRow do
				local checkbox = self:getFightBoxByCoordinate({i,j})
				local checkfighter = checkbox.currentFighter
				if checkfighter and checkfighter.isFriend then
					checkfighter.startBox = checkbox
				end
			end
		end
	end
	local function update( dt )		
		self.comboManager:passTime(dt)
		updateFighterStatus("Friend")
		updateFighterStatus("Enemy")
		do
			self.gameTime = self.gameTime + dt
			if self.battleStatusBefore ~= self.battleStatus then 
				self.battleStatusBefore = self.battleStatus
				if self.battleStatus == Macros.BattleStatus.kBuffEffect then
					-- print("buff......................")
					buffEffect()
					self.buffStartTime = self.gameTime
					schedulebuffeffect = self.scheduler:scheduleScriptFunc(playBuffEffect, 0.0167, false)
				elseif self.battleStatus == Macros.BattleStatus.kCastSkills then 
					-- print("cast......................")
					generateCasterList()
					self:executeCastSkill()				
				-- elseif self.battleStatus == Macros.BattleStatus.kEnemyBuffEffect then 
				--             -- print("buff effect enemy begin")
				--             buffEffect("Enemy")
				--             -- print("buff effect enemy over")
				elseif self.battleStatus == Macros.BattleStatus.kEnemyMove then 
					-- print("enemy move...............")
					enemyMove()
				-- elseif self.battleStatus == Macros.BattleStatus.kEnemyCastSkills then 
				--             generateCasterList("Enemy")
				--             schedulecastskill = self.scheduler:scheduleScriptFunc(castSkill, 0.0167, false)
				elseif self.battleStatus == Macros.BattleStatus.kEnemyAppear then 
					-- print("enemy appear.............")
					enemyAppear()
				elseif self.battleStatus == Macros.BattleStatus.kFriendMove then
					-- print("new turn")
					setFriendStartBox()
				end
			end
		end
		collectgarbage("collect")
	end
	local function initData(    )
		-- self.lsTouchHandler = LsTouchHandler.new()
		-- 从外部得到的东西
		self.battleInformation = require "battleInformationArena"
		self.ground = self.battleInformation.GroundInfos.Ground
		self.auras = {}
		-- Yi Feng 
		-- we need to alter this list ......
		self.fighterList = {
			Friend = GameStatus.TeamMembers[1],
			-- Friend = clone(GameStatus.TeamMembers[1]),
			Enemy = self.battleInformation.EnemyInfos.EnemyList,
		}
		-- print("fdasjfdsajf",type(GameStatus.TeamMembers[1]),#GameStatus.TeamMembers[1])
		-- print("friend type,\n",dump(self.fighterList.Friend))

		self.maxRow = Macros.FIGHTBOX_ROW
		self.minRow = 1
		self.captainIndex = {Friend=GameStatus.TeamCaptains,Enemy=GameStatus.TeamCaptains}
		self.captains = {Friend={},Enemy={}}

		self.totalFighterNumber = {
			Friend=#self.fighterList.Friend, 
			Enemy=#self.fighterList.Enemy,
		}

		self.fighterDead = {Friend=0, Enemy=0} 
	
		self.totalFighters = {Friend={}, Enemy={}}
		self.currentFighters = {Friend={}, Enemy={}}
		
		self.playCount = 1
		self.castStartTime = 0
		self.processList = {}
		self.playList = {}
		self.processReturnList = {}
		self.gameTime = 0
		self.battleStatus = Macros.BattleStatus.kFriendMove
		self.battleStatusBefore = Macros.BattleStatus.kFriendMove
		self.gameStatus = Macros.GameStatus.kPlaying
		-- Yi Feng
		--self.gameStatus = Macros.GameStatus.kGameWin
		self.casterCount = 1
		self.casterNumber = 0
		self.animationNumber = 0
		self.beganTouch = nil
		self.dragSprite = nil
		self.movingBox = nil
		self.caster = nil
		self.currentEnemy = 0
		self.comboManager = ComboManager.new(self)
		self.battleRatingSystem = BattleRatingSystem.new(self)
		-- By Yi Feng
        self.itemDroppedFromEnemy = {}

	end
	-- local function initSizeAndPosition(    )
	-- 	local layerwidth = Macros.FIGHTBOX_WIDTH * Macros.FIGHTBOX_COLUMN
	-- 	local layerheight = Macros.FIGHTBOX_HEIGHT * Macros.FIGHTBOX_ROW
	-- 	-- local layerSize = CCSizeMake(layerwidth, layerheight)
	     
	-- 	self:setContentSize(layerSize)
	-- 	self.winSize = CCDirector:sharedDirector():getWinSize()
	-- 	local y = 180+40-0.5*(768-self.winSize.height)
	-- 	self:setPosition(ccp(self.winSize.width - 71 - layerSize.width, y))
	-- 	--self:setPosition(ccp(70,180))
	-- 	-- print("winsize = -------------------",self.winSize.width)
	-- 	-- print("layersize = -----------------",layerSize.width)
	-- 	self.originX, self.originY = self:getPosition()

	-- 	-- print ("layerPosition:",self:getPosition())
	
	-- 	self.fightBoxLayer = CCLayer:create()
	-- 	self.fightBoxLayer.childrenlist = {}
	-- 	self.fightBoxLayer:setContentSize(layerSize)
	-- 	self.fightBoxLayer:setPosition(0,0)
	-- 	self.layer:addChild(self.fightBoxLayer, 1)

	-- 	self.fightBoxLayer:setVisible(false)
	
	-- 	self.fightFriendLayer = CCLayer:create()
	-- 	self.fightFriendLayer:setContentSize(layerSize)
	-- 	self.fightFriendLayer:setPosition(0,0)
	-- 	self.layer:addChild(self.fightFriendLayer, 1)
	-- 	self.fightFriendLayer:setVisible(false)
	
	-- 	self.fightEnemyLayer = self.fightFriendLayer
	
	-- 	self.fightUILayer = CCLayer:create()
	-- 	self.fightUILayer:setContentSize(layerSize)
	-- 	self.fightUILayer:setPosition(0,0)
	-- 	self.layer:addChild(self.fightUILayer, 1)
	-- 	self.fightUILayer:setVisible(false)
	-- end

	local function initUI()
        -- by Yi Feng, we need to rewrite the UI
        ----------------------------------------------------
        -- callbacks 
	    -- local function pausecallback()
	    -- 	 -- print("pause-----------------------")
     --         F_Pause.new():pos(self.winSize.width / 2 - self.originX,self.winSize.height / 2 - self.originY):addTo(self,100)
     --    end
    
        local function gocallback()
	    	  if self.battleStatus == Macros.BattleStatus.kFriendMove and not self.scheduleExecutePlayList then
				--print (self.battleStatus, Macros.BattleStatus.kFriendMove)
			     -- self.battleRatingSystem:newTurn()
				 self.battleStatus = Macros.BattleStatus.kBuffEffect
			  end
			  self.freeDrag = false
        end

        --background

        local bg = display.newSprite("F_bg.jpg"):pos(-self.originX+CCDirector:sharedDirector():getWinSize().width,-self.originY+CCDirector:sharedDirector():getWinSize().height/2)
		bg:setAnchorPoint(CCPoint(1,0.5))
		self.fightBoxLayer:addChild(bg, -1, Macros.BACKGROUND_TAG)
        -- auto button, auto fight
        local bottomPixel = 122-self.originY
        local upPixel = CCDirector:sharedDirector():getWinSize().height-10-self.originY
        local leftPixel = 23-self.originX
        local rightPixel = CCDirector:sharedDirector():getWinSize().width-self.originX-25
        local autoMenuItem = ui.newImageMenuItem({
			image = "autoButton.png",
			imageSelected = "autoButtonPressed.png",
			x = leftPixel,
			y = bottomPixel,
			tag = 2,
			listener = autocallback,

		})
		autoMenuItem:setAnchorPoint(CCPoint(0,1))

		local autoMenu = ui.newMenu({autoMenuItem})
		self.fightUILayer:addChild(autoMenu,100)
		-- continue button,click this, fight a round
		local continueMenuItem = ui.newImageMenuItem({
			image = "goButtonNormal.png",
			imageSelected = "goButtonPressed.png",
			x = rightPixel,
			y = bottomPixel,
			tag = 0,
			listener = gocallback,

		})
		continueMenuItem:setAnchorPoint(CCPoint(1,1))

		local continueMenu = ui.newMenu({continueMenuItem})	
		self.fightUILayer:addChild(continueMenu,100)

		pauseMenuItem:setAnchorPoint(CCPoint(0,1))

		local pauseMenu = ui.newMenu({pauseMenuItem})
		self.fightUILayer:addChild(pauseMenu,100)
		---下部UI(最好单独写一个控件出来)   
		if TestSettings.SuperSkillType == 2 then
			self.feverBar = F_FeverBar.new({
				x = 130,
				y = -90,
				comboParams = clone(self.battleInformation.ComboParams),
				battleField = self,
				})
    		self.feverBar:setAnchorPoint(ccp(0,1))
    		self.layer:addChild(self.feverBar, 1000000)
    		self.superSkillButton = {}
    		for i, currentfighter in ipairs(self.currentFighters["Friend"]) do
    			local PUSH_BUTTON_IMAGES = {
				    normal = "Button01.png",
				    pressed = "Button01Pressed.png",
				    disabled = "Button01Disabled.png",
				}
				self.superSkillButton[i] = cc.ui.UIPushButton.new(PUSH_BUTTON_IMAGES, {scale9 = true})
    			    :setButtonSize(100, 80)
    			    :setButtonLabel("normal", ui.newTTFLabel({
    			        text = currentfighter.fighter.Information.Name,
    			        size = 18
    			    }))
    			    :setButtonLabel("pressed", ui.newTTFLabel({
    			        text = "Super Pressed",
    			        size = 18,
    			        color = ccc3(255, 64, 64)
    			    }))
    			    :setButtonLabel("disabled", ui.newTTFLabel({
    			        text = currentfighter.fighter.Information.Name,
    			        size = 18,
    			        color = ccc3(0, 0, 0)
    			    }))
    			    :onButtonClicked(function(event)
    			    	self.superSkillButton[i].fighter.skillState.IsReadyToCastSuper = true
    			       	self.superSkillButton[i].fighter:preCastSkill(0)
    			       	self:executeCastSkill(  )
    			       	--如果cd不为0，证明成功释放，禁用按钮。反之证明释放不成功，重置状态。
    			       	if self.superSkillButton[i].fighter.skillState.CoolDown ~= 0 then
							self.superSkillButton[i]:setButtonEnabled(false)
							self.superSkillButton[i].fighter.battleField.comboManager:stopTimer()
						else
							self.superSkillButton[i].fighter.skillState.IsReadyToCastSuper = false
						end
    			    end)
    			    :align(display.LEFT_CENTER, 150 + 115 * i , -90)
    			    :addTo(self)
    			if currentfighter.skillState.CoolDown == 0 then
					self.superSkillButton[i]:setButtonEnabled(true)
				else
					self.superSkillButton[i]:setButtonEnabled(false)
				end
  				self.superSkillButton[i].fighter = currentfighter
    		end
		else
			local skillBox = display.newSprite("skillBoxNew.png"):pos(CCDirector:sharedDirector():getWinSize().width/2-self.originX,-self.originY+6)
			skillBox:setAnchorPoint(CCPoint(0.5,0))
			skillBox.size = skillBox:getContentSize()
			self.fightUILayer:addChild(skillBox,100)
			  -- items in the box
			  -- heroportrait
			  -- we should put captain here initially
			-- local heroPortrait = display.newSprite("honghaier.png"):pos(356,224)     
  --    	   heroPortrait:setAnchorPoint(CCPoint(0,1))
  --    	   skillBox:addChild(heroPortrait)
        	-- xulicao
        	-- local xuLi = display.newSprite("xuLi.png"):pos(0,118)
        	-- skillBox:addChild(xuLi)
        	-- skill1
        	for i = 1,3 do 
        		local itemKuang = display.newSprite("itemKuang.png"):pos(skillBox.size.width/2+100*(i-2),skillBox.size.height-40):addTo(skillBox,3)
        		itemKuang:setAnchorPoint(ccp(0.5,1))
        	end
        	local skill1 = display.newSprite("skill3.png"):pos(skillBox.size.width/2-100,skillBox.size.height-50)
        	skill1:setAnchorPoint(CCPoint(0.5,1))
        	skillBox:addChild(skill1)
        	-- skill2
        	local skill2 = display.newSprite("skill3.png"):pos(skillBox.size.width/2,skillBox.size.height-50)
        	skill2:setAnchorPoint(CCPoint(0.5,1))
        	skillBox:addChild(skill2)
        	-- skill3
        	local skill3 = display.newSprite("skill3.png"):pos(skillBox.size.width/2+100,skillBox.size.height-50)
        	skill3:setAnchorPoint(CCPoint(0.5,1))
        	skillBox:addChild(skill3)
	
	
	       	
					
		   	
	       	----------------------------------------------------
			self.itemBox={}
			self.itemBox[1] = skill1
		    self.itemBox[2] = skill2 
		    self.itemBox[3] = skill3 

			-- we need to rewrite this part
			--local items = {"ZhaDan", "HuiHunDan", "WuDiZhouFu"}
       		--local items = {{name = "ZhaDan", number = 5}, {name = "HuiHunDan", number = 5},{name = "WuDiZhouFu", number = 5}}
	   		for key,value in pairs(self.itemlist) do 
	   	        F_ItemBoxNew.new({positionX = 46, positionY = 46, item = value, battleField = self}):addTo(self.itemBox[key],2)
	   	    end 
	   		--local item = F_ItemBoxNew.new({positionX = 46, positionY = 46, item = items[1], battleField = self}):addTo(skill1,2)
			-- self.informationBox = F_InformationBox.new()
			self.SuperSkillBox = F_SuperSkill.new()
			-- self.informationBox:setPosition(0, -110)
			self.SuperSkillBox:setPosition(428,172)
       		self.SuperSkillBox.battleField = self
       		skillBox:addChild(self.SuperSkillBox)
       	
		-- self.informationBox.battleField = self
		-- self.fightUILayer:addChild(self.informationBox)

		-- -- by Yi Feng
		-- -- this itembox is used to collect items dropped from dead enemy
		-- local item_box = display.newSprite("itemBox.jpg"):pos(100,display.height-180) 
		-- self.fightUILayer:addChild(item_box,100)
  --       local item_icon = display.newSprite("b_addenergy1.png"):pos(60,42)
		-- item_box:addChild(item_icon,1)
  --       self.item_number = ui.newTTFLabel({
		--                   text			= "0",
		--                   font			= "Arial",
		--                   size			= 30,
		--                   x             	= 20,
	 --                      y             	= 42,
	 --                      color			= ccc3(123,123,234),
	 --                      align			= ui.TEXT_ALIGN_LEFT,
	    
	 --                      }):addTo(item_box,1)
			self.feverBar = F_FeverBar.new({
				--background = "FeverBarBG.png",
				--x = self.winSize.width / 2 - self.originX,
				--y = self.winSize.height - 30 - self.originY,
				x = 15,
				y = 75,
				-- fullPercentage = 100,
				-- emptyPercentage = 15,
				comboParams = clone(self.battleInformation.ComboParams),
				battleField = self,
				})
    	    self.feverBar:setAnchorPoint(ccp(0,1))
			--local xuLi = display.newSprite("xuLi.png"):pos(0,118)
    	    skillBox:addChild(self.feverBar)
    	    local leaf = display.newSprite("leaf.png"):pos(424,skillBox.size.height-106)
    	    leaf:setAnchorPoint(ccp(0,1))
    	    skillBox:addChild(leaf,5)
    	end

    	self.comboLabel = F_ComboLabel.new(self)
		self.layer:addChild(self.comboLabel, Macros.ZORDER.F_ComboLabel)
		
	end

		local function sortFighters()

		local enemyorder = 1
		local orderenemy = {}
		for i=4,1 do
			for j=1,4 do
				for index,currentfighter in pairs(self.fighterList["Enemy"]) do
					if {j,i}==currentfighter.initPos then
						orderenemy[enemyorder] = index
						enemyorder = enemyorder + 1
					end
				end
			end
		end
		local friendorder = 1
		local orderfriend = {}

		for i=4,1 do
			for j=5,8 do
				for index,currentfighter in pairs(self.fighterList["Friend"]) do
					if {j,i}==currentfighter.initPos then
						orderfriend[friendorder] = index
						friendorder = friendorder + 1
					end
				end
			end
		end

		self.fightorder = {}
		for i=1,5 do
			self.fightorder[i*2-1] = {"Enemy",orderenemy[i]}
			self.fightorder[i*2] = {"Friend", orderfriend[i]}	
		end


	end
	initData()

	initFighters("Friend")
			print("fdsajfkljdaslfjdklsajflkdjsafkldjalfjadlsjfdklaskl")

	initFighters("Enemy")
	sortFighters()
	print("hey here",dump(self.fighterorder))


	-- self:addNodeEventListener(cc.NODE_EVENT,onNodeEvent)
	while true do
		
	end	
	-- self:scheduleUpdate()
end
-- print("hey there,",type(playList))
function FightScene:refreshFeverBuff(time)
	-- print ("refresh fever buff")
	local feverBuff = {}
	feverBuff.object = self.feverBar.comboParams.effect.effectobject
	if self.feverBar.currentSection ~= 0 then
		feverBuff.aura = self.feverBar.comboParams.effect.effect[self.feverBar.currentSection]
		for k,v in pairs(feverBuff.aura) do
			-- print("aura",k,v)
		end
	else
		feverBuff.aura = {}
	end
	for _, currentfighter in pairs(self.currentFighters["Friend"]) do
		currentfighter:refreshFeverBuff(feverBuff, time)
	end
end

-- function FightScene:getFightBoxByTouchPoint( touchpoint )
-- 	local x, y
-- 	if touchpoint.x > self.originX then
-- 		x,_ = math.modf((touchpoint.x - self.originX)/Macros.FIGHTBOX_WIDTH)+1
-- 	else
-- 		x = 0
-- 	end
-- 	if touchpoint.y>self.originY then
-- 		y,_ = math.modf((touchpoint.y - self.originY)/Macros.FIGHTBOX_HEIGHT)+1
-- 	else
-- 		y = 0
-- 	end
-- 	return self:getFightBoxByCoordinate( {x,y} )
-- end

-- function FightScene:getFightBoxByCoordinate( cor )
-- 	--通过坐标直接获得格子
-- 	local ret = nil
-- 	for k,v in pairs(self.fightBoxLayer.childrenlist) do
-- 		if k[1] == cor[1] and k[2] == cor[2] then 
-- 			ret = v
-- 			break
-- 		end
-- 	end
-- 	return ret
-- end
-- function FightScene:setCharacterToPosition( box, fighter )
-- 	--角色形象和数据同时放在某个格子上
-- 	self:setCharacterDataToPosition(box, fighter)
-- 	self:setDisplayToPosition(box, fighter)
-- end
-- function FightScene:setCharacterDataToPosition( box, fighter )
-- 	--只把角色数据绑定在某格子上，形象不移动过去
-- 	fighter.currentBox = box
-- 	box.currentFighter = fighter
-- end
-- function FightScene:setDisplayToPosition( box, fighter )
-- 	--将角色显示放在指定格子里，用射影变换确定位置
-- 	local x, y = box:getPosition()
-- 	x = x + self.originX
-- 	y = y + self.originY
-- 	xnew, ynew = transformPoint( x,y, "inverse" )
-- 	xnew = xnew - self.originX
-- 	ynew = ynew - self.originY
-- 	local positionToAdd = CCPoint(xnew,ynew)
-- 	-- positionToAdd = ccp(x,y)
-- 	-- print("setPosition",x,y)
-- 	fighter:setPosition(positionToAdd)
-- end
-- function FightScene:moveCharacterToCurrent( fighter )
-- 	-- print("movecharac------------------")
-- 	--将角色移动到他数据所在的格子里，用到射影变换确定位置
-- 	local curBox = fighter.currentBox
-- 	local x, y = curBox:getPosition()
-- 	x = x + self.originX
-- 	y = y + self.originY
-- 	xnew, ynew = transformPoint( x,y, "inverse" )
-- 	xnew = xnew - self.originX
-- 	ynew = ynew - self.originY
-- 	local positionToMove = CCPoint(xnew,ynew)
-- 	fighter:runAction(CCMoveTo:create(0.5,positionToMove))
-- 	return 0.5
-- end
-- function FightScene:setBoxAccess()
-- 	--对于拖起来的不同选手，设置不同的可达格子
-- 	-- local moveability = self.dragSprite.fighter.Ability.MoveFriend + self.dragSprite.deltaAbility.MoveAbility
-- 	local moveability = Formulas.getFriendMoveAblilty(self.dragSprite.calculatingParams)
-- 	-- local moveability = 100
-- 	if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
-- 		moveability = 0
-- 	end
-- 	for i = 1, Macros.FIGHTBOX_COLUMN do
-- 		for j = self.minRow, self.maxRow do
-- 			local checkbox = self:getFightBoxByCoordinate({i,j})
-- 			if not checkbox.placeFriendAvailable or checkbox.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE or (checkbox.currentFighter and not checkbox.currentFighter.isFriend) or moveability < checkbox:getDistanceToBox(self.dragSprite.startBox) then
-- 				checkbox.accessable = false
-- 			end
-- 			checkbox:setVisualEffectNormal(self.dragSprite)
-- 		end
-- 	end 
-- end
-- function FightScene:resetBoxAccess()
-- 	--假设所有格子都可达
-- 	for i = 1, Macros.FIGHTBOX_COLUMN do
-- 		for j = self.minRow, self.maxRow do
-- 			local checkbox = self:getFightBoxByCoordinate({i,j})
-- 			checkbox.accessable = true
-- 			checkbox:setVisualEffectNormal()
-- 		end
-- 	end
-- end
-- function FightScene:onMoveBox( move, event )
-- 	if move and move.accessable then 
-- 		if ((move.placeFriendAvailable) and (move.contentType < Macros.FIGHTBOX_ACCESSABLETYPE) and (not move.currentFighter or move.currentFighter.isFriend)) then 
-- 			-- print("onMoveBox: can place")
-- 			--下面一长串都是设置攻击范围等的视觉效果
-- 			local range = self.dragSprite.fighter.NormalAtk.Range
-- 			if type(range) ~= "table" then
-- 				range = Macros.FullScreen
-- 			end
-- 			if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
-- 				range = {}
-- 			end
-- 			local firstTargetNotReachedNormal = true
-- 			local firstTargetNotReachedNormalLast = true
-- 			for rangekey,rangevalue in pairs(range) do
-- 				local posOfBox = move:getPosOfRelativeBox(rangevalue)
-- 				-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
-- 				if posOfBox and posOfBox[1] ~= 0 then
-- 					local boxToCheck = self:getFightBoxByCoordinate(posOfBox)
-- 					if event == "In" then
-- 						if boxToCheck.currentFighter and boxToCheck.currentFighter.isFriend == self.dragSprite.fighter.NormalAtk.ReceiverIsFriend then
-- 							firstTargetNotReachedNormal = false
-- 						end
-- 						if firstTargetNotReachedNormal ~= firstTargetNotReachedNormalLast then
-- 							boxToCheck:setVisualEffectAoe(self.dragSprite, rangekey, "hitbox")
-- 							firstTargetNotReachedNormalLast = false
-- 						else
-- 							boxToCheck:setVisualEffectAoe(self.dragSprite, rangekey, firstTargetNotReachedNormal)
-- 						end
-- 					elseif event == "Out" or event == "Place" then 
-- 						boxToCheck:setVisualEffectNormal(self.dragSprite)
-- 					end
-- 				end
-- 			end
-- 			if self.dragSprite.skillState.CoolDown == 0 then
-- 				local range2 = self.dragSprite.fighter.SuperAtk.Range
-- 				if type(range2) ~= "table" then
-- 					range2 = Macros.FullScreen
-- 				end
-- 				if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
-- 					range2 = {}
-- 				end
-- 				local firstTargetNotReachedSuper = true
-- 				local firstTargetNotReachedSuperLast = true
-- 				for rangekey,rangevalue in pairs(range2) do
-- 					local posOfBox = move:getPosOfRelativeBox(rangevalue)
-- 					-- print("第n个格子",rangekey)
-- 					-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
-- 					if posOfBox and posOfBox[1] ~= 0 then
-- 						local boxToCheck = self:getFightBoxByCoordinate(posOfBox)
-- 						if event == "In" then
-- 							if boxToCheck.currentFighter and boxToCheck.currentFighter.isFriend == self.dragSprite.fighter.SuperAtk.ReceiverIsFriend then
-- 								firstTargetNotReachedSuper = false
-- 							end
-- 							if firstTargetNotReachedSuper ~= firstTargetNotReachedSuperLast then
-- 								boxToCheck:setVisualEffectSuper(self.dragSprite, rangekey, "hitbox")
-- 								firstTargetNotReachedSuperLast = false
-- 							else
-- 								boxToCheck:setVisualEffectSuper(self.dragSprite, rangekey, firstTargetNotReachedSuper)
-- 							end
-- 						elseif event == "Out" or event == "Place" then 
-- 							boxToCheck:setVisualEffectSuperNormal(self.dragSprite)
-- 						end
-- 					end
-- 				end
-- 			end
-- 			if event == "In" then 
-- 				-- print("onMoveBox: Move In, move.currentFighter!",move.currentFighter)
-- 				move:setVisualEffectPlace()
-- 			elseif event == "Out" or event == "Place" then 
-- 				-- print("onMoveBox: Move Out!")
-- 				move:setVisualEffectNormal(self.dragSprite)
-- 			end
-- 			-- print("onMoveBox: currentFighter: ",move.currentFighter)
-- 			--如果格子里的人被晕了或者定身，行动值变0
-- 			if move.currentFighter and move.currentFighter.isFriend then 
-- 				-- print("onMoveBox: currentFighter: ",move.currentFighter)
-- 				local moveability = Formulas.getFriendMoveAblilty(move.currentFighter.calculatingParams)
-- 				-- local moveability = 100
-- 				if move.currentFighter.buffAddon.Stun or move.currentFighter.buffAddon.Freeze then
-- 					moveability = 0
-- 				end
-- 				-- for k,v in pairs(move.currentFighter.currentBuffs) do
-- 				--             if k.buffType == "Stun" or k.buffType == "Freeze" then 
-- 				--                            moveability = 0
-- 				--             end
-- 				-- end    
-- 				if move.currentFighter ~= self.dragSprite then 
-- 					if moveability >= move:getDistanceToBox(self.dragSprite.currentBox) then
-- 						--格子里有人且能交换位置，则交换位置
-- 						if event == "In" then 
-- 							self:setDisplayToPosition(self.dragSprite.currentBox, move.currentFighter)
-- 						elseif event == "Out" then 
-- 							self:setDisplayToPosition(move.currentFighter.currentBox, move.currentFighter)
-- 						elseif event == "Place" then 
-- 							self:setCharacterToPosition(self.dragSprite.currentBox, move.currentFighter)
-- 							self:setCharacterToPosition(move, self.dragSprite)
-- 							self:newTurn()
-- 						end
-- 					elseif event == "Place" then 
-- 						--如果要摆的格子里的人移动不了这么远，则放回原格子
-- 						self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
-- 					end
-- 				elseif event == "Place" then
-- 					--摆在自己原来的格子里，摆下就ok
-- 					self:setCharacterToPosition(move, self.dragSprite)
-- 				end
-- 			elseif event == "Place" then 
-- 				--摆在空格子里面，原格子设空
-- 				self.dragSprite.currentBox:setEmpty()
-- 				self:setCharacterToPosition(move, self.dragSprite)
-- 				self:newTurn()
-- 			end
-- 		elseif event == "Place" then 
-- 			--后面两项对应：结束点不在格子里或者格子不能摆东西，那么把拖动人物放回自己格子
-- 			self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
-- 		end
-- 	elseif event == "Place" then 
-- 		self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
-- 	end
-- end
-- function FightScene:touchEventAction( touch, touchtype )
-- 	-- print("touch called")
-- 	--lstouch用来处理不同点击事件，只有在FriendMove阶段点击有效
-- 	--type 0 点击
-- 	--type 1 移动
-- 	--type 2 结束
-- 	--type 3 取消
-- 	--lstouch很好用，还可以用来处理一些其他touch事件，比如长按，双击，甚至手势等。
-- 	if self.battleStatus == Macros.BattleStatus.kFriendMove  and not(isitem)then 
-- 		if touchtype == 0 then 
-- 			 -- collectgarbage("collect")
-- 			 -- local l1 = collectgarbage("count")
-- 			 -- print("collect count:", l1)
-- 			-- print("touchtype == 0")
-- 			--清空屏幕下方状态栏
-- 			-- self.informationBox:addFighter()
-- 			if TestSettings.SuperSkillType == 1 then 
-- 				self.SuperSkillBox:addFighter()
-- 			end
-- 			if touch then
-- 				--如果点到格子，则在状态栏里面加入格子里面的选手				
-- 				--self.informationBox:addFighter(touch.currentFighter)
-- 				if TestSettings.SuperSkillType == 1 then
-- 					self.SuperSkillBox:addFighter(touch.currentFighter)
-- 				end
-- 				--初始格子
-- 				self.touchBeganBox = touch
-- 				--正在占用的格子
-- 				self.movingBox = self.touchBeganBox
-- 				--如果点到的友方人物，则设置为拖动角色，并且初始化拖动属性
-- 				if self.touchBeganBox.currentFighter and self.touchBeganBox.currentFighter.isFriend then
-- 					if not self.touchBeganBox.currentFighter.buffAddon.Chaos then
-- 						self.dragSprite = self.touchBeganBox.currentFighter
-- 						self.beganDistance = (ccpSub(self.beganPoint, ccp(self.dragSprite:getPosition())))
-- 						-- self.dragSprite:setPosition(ccpSub(self.beganPoint, CCPoint(self.originX,self.originY)))					
-- 						if self.dragSprite.type == "cocostudio" then
-- 		            	    self.dragSprite.armature:getAnimation():play("run")
--                     	else
--                     	    -- 	if not self.dragSprite.isFriend then 
--     	            	       -- SkeletonManager.run(self.dragSprite.armature,Skeletons.zhubajie)
--     	            	       --  else
--     	            	   	SkeletonManager.run(self.dragSprite.armature,self.dragSprite.fighter.Skeleton)
--                     	        -- end   
--                     	end
-- 						self:setBoxAccess()
-- 						self:onMoveBox(self.touchBeganBox, "In")
-- 					end
-- 				end
-- 				--如果是敌方角色，显示下回合攻击范围
-- 				if self.touchBeganBox.currentFighter and ((not self.touchBeganBox.currentFighter.isFriend) or (self.touchBeganBox.currentFighter.isFriend and self.touchBeganBox.currentFighter.buffAddon.Chaos)) then
-- 					self.checkingEnemy = self.touchBeganBox.currentFighter
-- 					local range = (self.checkingEnemy.skillState.IsReadyToCastSuper and self.checkingEnemy.fighter.SuperAtk.Range) or self.checkingEnemy.fighter.NormalAtk.Range
-- 					if type(range) ~= "table" then
-- 						range = Macros.FullScreen
-- 					end
-- 					if self.checkingEnemy.buffAddon.Stun or self.checkingEnemy.buffAddon.Freeze then
-- 						range = {}
-- 					end
-- 					for rangekey,rangevalue in pairs(range) do
-- 						if self.checkingEnemy.isFriend or not self.checkingEnemy.buffAddon.Chaos then
-- 							rangevalue = {-rangevalue[1],rangevalue[2]}
-- 						end
-- 						local posOfBox = self.touchBeganBox:getPosOfRelativeBox(rangevalue)
-- 						-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
-- 						if posOfBox and posOfBox[1] ~= 0 then 
-- 							self:getFightBoxByCoordinate(posOfBox):setVisualEffectAoe(self.checkingEnemy)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		elseif touchtype == 1 then 
-- 			-- print("touchtype == 1")
-- 			if self.dragSprite then 
-- 				self.dragSprite:setPosition(ccpSub(self.movePoint, self.beganDistance))
-- 				local moveBox = self:getFightBoxByTouchPoint(ccpAdd(ccp(self.dragSprite:getPosition()), CCPoint(self.originX,self.originY)))
-- 				-- if touch then 
-- 				-- 	--当前的格子
-- 				-- 	moveBox = touch
-- 				-- end
-- 				-- print("moveBox, self.movingBox == ", moveBox, self.movingBox)
-- 				if moveBox ~= self.movingBox then 
-- 					--如果当前的格子和之前格子不同，处理进出格子事件
-- 					-- print("Out Box!")
-- 					self:onMoveBox(self.movingBox, "Out")
-- 				  	-- print("In Box!")
-- 					self:onMoveBox(moveBox, "In")
-- 					self.movingBox = moveBox
-- 				end
-- 			end
-- 		elseif touchtype == 2 then 
-- 			-- print("touchtype == 2")
-- 			if self.dragSprite then 
-- 				local endBox = self:getFightBoxByTouchPoint(ccpAdd(ccp(self.dragSprite:getPosition()), CCPoint(self.originX,self.originY)))
-- 				-- if touch then 
-- 				-- 	--结束格子
-- 				-- 	endBox = touch
-- 				-- end
-- 				if endBox ~= self.movingBox then
-- 				--如果没有结束在之前的格子里，先出格子 
-- 					self:onMoveBox(self.movingBox, "Out")
-- 				end
-- 				--放置格子事件
-- 				self:onMoveBox(endBox, "Place")
-- 				self:resetBoxAccess()
-- 			end
-- 			--如果之前显示了敌方角色的信息，则恢复显示
-- 			if self.checkingEnemy then
-- 				local range = (self.checkingEnemy.skillState.IsReadyToCastSuper and self.checkingEnemy.fighter.SuperAtk.Range) or self.checkingEnemy.fighter.NormalAtk.Range
-- 				if type(range) ~= "table" then
-- 					range = Macros.FullScreen
-- 				end
-- 				if self.checkingEnemy.buffAddon.Stun or self.checkingEnemy.buffAddon.Freeze then
-- 					range = {}
-- 				end
-- 				for rangekey,rangevalue in pairs(range) do
-- 					if self.checkingEnemy.isFriend or not self.checkingEnemy.buffAddon.Chaos then
-- 							rangevalue = {-rangevalue[1],rangevalue[2]}
-- 					end
-- 					local posOfBox = self.touchBeganBox:getPosOfRelativeBox(rangevalue)
-- 					-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
-- 					if posOfBox and posOfBox[1] ~= 0 then 
-- 						self:getFightBoxByCoordinate(posOfBox):setVisualEffectNormal(self.checkingEnemy)
-- 					end
-- 				end
-- 			end
-- 		elseif touchtype == 3 then 
-- 			-- print("touchtype == 3")
-- 			if self.dragSprite then 
-- 				local cancelBox
-- 				if touch then 
-- 					cancelBox = touch
-- 				end
-- 				self:onMoveBox(cancelBox, "Out")
-- 				self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
-- 				resetBoxAccess()
-- 			end
-- 			if self.checkingEnemy then
-- 				local range = (self.checkingEnemy.skillState.IsReadyToCastSuper and self.checkingEnemy.fighter.SuperAtk.Range) or self.checkingEnemy.fighter.NormalAtk.Range
-- 				if self.checkingEnemy.buffAddon.Stun or self.checkingEnemy.buffAddon.Freeze then
-- 					range = {}
-- 				end
-- 				for rangekey,rangevalue in pairs(range) do
-- 					rangevalue = {-rangevalue[1],rangevalue[2]}
-- 					local posOfBox = self.touchBeganBox:getPosOfRelativeBox(rangevalue)
-- 					-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
-- 					if posOfBox and posOfBox[1] ~= 0 then 
-- 						self:getFightBoxByCoordinate(posOfBox):setVisualEffectNormal(self.checkingEnemy)
-- 					end
-- 				end
-- 			end
-- 		end

-- 	-------------------altered here by hd
-- 	end

-- end

--function FightScene:touchEventItem( item, event )

	--[[if self.battleStatus == Macros.BattleStatus.KItemMove then 
		print("flag")
		if touchtype == 0 then 
			print("touchtype == 1")
			print("flag2")
			item[itemflag]:setPosition(event.x,event.y)
		end
	end]]--

--按时间不同自动插入列表位置
function FightScene:addProcess( time, func, parameters )
	if time == Macros.Instance then

		func(unpack(parameters))
		self:executeCastSkill(  )
	else
		if self.processList[1] == nil then
			table.insert(self.processList, {time, func, parameters, 1})
			return 1
		else
			local pos = 1
			while self.processList[pos] and self.processList[pos][1] <= time do
				pos = pos + 1
			end
			-- index is number of processes
			local index = #self.processList + 1
			table.insert(self.processList, pos, {time, func, parameters, index})
			return index
		end
	end
end
function FightScene:addPlay( time, func, parameters )
	-- if time == Macros.Instance then
	-- 	func(unpack(parameters))
	-- else
		if self.playList[1] == nil then
			table.insert(self.playList, {time, func, parameters})
		else
			local pos = 1
			while self.playList[pos] and self.playList[pos][1] <= time do
				pos = pos + 1
			end
			table.insert(self.playList, pos, {time, func, parameters})
		end
	-- end
end

function FightScene:newTurn()
	if not self.freeDrag then
		if self.battleStatus == Macros.BattleStatus.kFriendMove and not self.scheduleExecutePlayList then
			-- self.battleRatingSystem:newTurn()
			-- Actions.Shake(self,1,2,1005)
			self.battleStatus = Macros.BattleStatus.kBuffEffect
		end
	end
end

return FightScene