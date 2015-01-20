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


local class = require "class"
local skynet = require "skynet"
local FightScene = class("FightScene")
local Macros = require "Macros"
local GameStatus = require "GameStatus"
local Functions = require "Functions"
local Tables = require "Tables"
local FighterInBattle = require "FighterInBattle"
local Formulas = require "Formulas"
local ComboManager = require "ComboManager"
local BattleRatingSystem = require "BattleRatingSystem"
local FightBox = require "FightBox"
local F_FeverBar = require "F_FeverBar" 

function FightScene:ctor(attackerHeroList, defencerHeroList, attackerCaptainList, defencerCaptainList)
	print("FightScene inited")
	local res = self:init(attackerHeroList, defencerHeroList, attackerCaptainList, defencerCaptainList)
	print("fightscene inited finished")
	self.currentWaitTime = 0
	print("flage,",type(res))
	self.process = res
	return res
end


local function transformPoint(x,y,direction)
	return x,y
end



function FightScene:executeProcessList()
	local processCount = 1
	while(self.processList[processCount]) do
		local vRet = self.processList[processCount][2](unpack(self.processList[processCount][3]))
		print("self.processlist[processcount]",self.processList[processCount])
		print("position,",self.processList[processCount][4])
		print("processCount,",processCount)
		-- print("vRet", vret)
		-- table.insert(self.processReturnList, self.processList[processCount][4], vRet)
		processCount = processCount + 1
	end
	print("end of executeProcessList")

end

function FightScene:executeCastSkillEnemy(  )
	print("execute cast skill Friend")
	--完整的一套运行列表体系（释放正常技能，大招，包括以后可能的物品逻辑）
	self:executeProcessList(  )
	--如果是在放技能阶段（正常技能），则结算CD时间。
	if self.battleStatus == Macros.BattleStatus.kCastSkills then
		-- for index, checkfighter in pairs(self.currentFighters["Enemy"]) do  
		-- 	--如果敌人CD没到，而且敌人有大招
			if localfighter.skillState.CoolDown ~= 0 and localfighter.fighter.SuperAtk.Name then 
				--如果还有一回合CD，那他下回合就准备放大。
				if localfighter.skillState.CoolDown == 1 then
					-- print("tocast=super")
					localfighter.skillState.IsReadyToCastSuper = true
				end
				--CD减1
				localfighter.skillState.CoolDown = localfighter.skillState.CoolDown - 1
			end
		-- end
		-- for index, checkfighter in pairs(self.currentFighters["Friend"]) do  
		-- --如果CD没到0，且有大招，CD减1
		-- 	if checkfighter.skillState.CoolDown ~= 0 and checkfighter.fighter.SuperAtk.Name then 
		-- 		checkfighter.skillState.CoolDown = checkfighter.skillState.CoolDown - 1
		-- 	end
		-- end
	end
	--设置放技能开始时间
	self.castStartTime = self.gameTime
	--调度执行播放列表的函数
	-- if not self.scheduleExecutePlayList then
	-- 	self.scheduleExecutePlayList = self.scheduler:scheduleScriptFunc(handler(self, self.executePlayList), 0.0167, false)
	-- end
end

function FightScene:executeCastSkillFriend(  )
	print("execute cast skill Friend")
	--完整的一套运行列表体系（释放正常技能，大招，包括以后可能的物品逻辑）
	self:executeProcessList(  )
	--如果是在放技能阶段（正常技能），则结算CD时间。
	if self.battleStatus == Macros.BattleStatus.kCastSkills then
		-- -- for index, checkfighter in pairs(self.currentFighters["Enemy"]) do  
		-- -- 	--如果敌人CD没到，而且敌人有大招
		-- 	if localfighter.skillState.CoolDown ~= 0 and localfighter.fighter.SuperAtk.Name then 
		-- 		--如果还有一回合CD，那他下回合就准备放大。
		-- 		if localfighter.skillState.CoolDown == 1 then
		-- 			-- print("tocast=super")
		-- 			localfighter.skillState.IsReadyToCastSuper = true
		-- 		end
		-- 		--CD减1
		-- 		localfighter.skillState.CoolDown = localfighter.skillState.CoolDown - 1
		-- 	end
		-- -- end
		-- for index, checkfighter in pairs(self.currentFighters["Friend"]) do  
		--如果CD没到0，且有大招，CD减1
			if checkfighter.skillState.CoolDown ~= 0 and checkfighter.fighter.SuperAtk.Name then 
				checkfighter.skillState.CoolDown = checkfighter.skillState.CoolDown - 1
			end
		-- end
	end
	--设置放技能开始时间
	self.castStartTime = self.gameTime
	--调度执行播放列表的函数
	-- if not self.scheduleExecutePlayList then
	-- 	self.scheduleExecutePlayList = self.scheduler:scheduleScriptFunc(handler(self, self.executePlayList), 0.0167, false)
	-- end

end

function FightScene:init( attackerHeroList, defencerHeroList, attackerCaptainList, defencerCaptainList)
	-- self.scheduleExecutePlayList = nil



	local function initData()
		self.battleInformation = require "battleInformationArena"
		self.ground = {
		{0,0,0,0,0,0,0,0,},
		{0,0,0,0,0,0,0,0,},
		{0,0,0,0,0,0,0,0,},
		{0,0,0,0,0,0,0,0,},
		}
		self.auras = {}

		self.fighterList = {
			Friend = attackerHeroList,
			Enemy = defencerHeroList,
		}
		print("flagee,",dump(self.fighterList.Friend))
		print("flagee,",dump(self.fighterList.Enemy))

		self.maxRow = Macros.FIGHTBOX_ROW
		self.minRow = 1
		self.captainIndex = {Friend = attackerCaptainList, Enemy = defencerCaptainList}
		self.totalFighterNumber = {
			Friend = #self.fighterList.Friend,
			Enemy = #self.fighterList.Enemy,
		}

		self.fighterDead = {Friend = 0, Enemy = 0}
		self.pointFriend = 0
		self.pointEnemy = 0
		self.point = {2,2,3,4}
		self.pointCount = 0
		self.gameTurn = 0
		--------------
		self.string = ""
		self.process = ""
		--------------
		self.totalFighters = {Friend = {}, Enemy = {}}
		self.currentFighters = {Friend ={}, Enemy = {}}
		self.fightBoxLayer = {}
		self.fightBoxLayer.childrenlist = {}
		self.playCount = 1
		self.castStartTime = 0
		self.processList = {}
		self.playList = {}
		self.playPrintList = {}
		self.processReturnList = {}
		self.gameTime = 0
		self.rowFinished = 0
		self.rowDone = {}
		for i=1,4 do
			self.rowDone[i] = false
		end
		self.battleStatus = Macros.BattleStatus.kFriendMove
		self.battleStatusBefore = Macros.BattleStatus.kFriendMove
		self.gameStatus = Macros.GameStatus.kPlaying

		self.friendFinished = 0
		self.enemyFinished = 0

		self.casterCount = 1
		self.casterNumber = 0
		self.animationNumber = 0
		-- self.beganTouch = nil
		-- self.dragSprite = nil
		-- self.movingBox = nil
		self.caster = nil
		self.currentEnemy = 0
		self.comboManager = ComboManager.new(self)
		self.battleRatingSystem = BattleRatingSystem.new(self)

		-- self.itemDroppedFromEnemy = {}
		-- local iNumberFood = #self.battleInformation.ItemInfos.RewardsFood			
	end

	local function addFighter(fighterToAdd,camp,index)
		for _, currentfighter in pairs(self.currentFighters[camp]) do
			if currentfighter.isCaptain then
				print(currentfighter.fighterName,"is captain and is adding buff")
				fighterToAdd:addOrRemoveCaptainBuff(currentfighter.fighter, "Add")
			end
		end

		table.insert(self.currentFighters[camp], fighterToAdd)
		print("camp",camp,self.currentFighters[camp][#self.currentFighters[camp]].fighterName)
		if fighterToAdd.isCaptain then
			print("isCaptain")
			for _, fightersinbattle in pairs(self.currentFighters[camp]) do
				print("captain add buff")
				fightersinbattle:addOrRemoveCaptainBuff(fighterToAdd.fighter, "Add")
			end
		end
		self.currentFighters[camp][#self.currentFighters[camp]].index = index
	end

	local function initFighters(camp)

		for index, fighterinfo in pairs(self.fighterList[camp]) do
			-- print("===========================")
			-- print(index)
			-- print(dump(fighterinfo))
			local fighterName = fighterinfo.Fighter.Name
			local fighterToAdd
			if Functions.belongsToTable(fighterName, Tables.FighterScripts) then
				print("fighterScrips,",fighterName)
				local fighterScript = require (fighterName.."Script")
				fighterToAdd = fighterScript.new()
			else
				fighterToAdd = FighterInBattle.new()
			end

			if camp == "Friend" then
				fighterToAdd:initWithFighterInformation(fighterinfo, true, self)
			else
				fighterToAdd:initWithFighterInformation(fighterinfo, false, self)
			end

			-- print(fighterName,fighterToAdd.battleField)

			if index ==self.captainIndex[camp] then
				fighterToAdd.isCaptain = true
				print("Captain found here!!!")
			end
			if fighterinfo.onStage == 0 then
				fighterToAdd.pos = fighterinfo.initPos
				addFighter(fighterToAdd, camp, index)

				local toSetBox = self:getFightBoxByCoordinate(fighterinfo.initPos)
				self:setCharacterToPosition(toSetBox, fighterToAdd)
				if camp == "Friend" then
					fighterToAdd.startBox = toSetBox
				end
			end
			-- print("self.fighterlist[camp][index][cor]",camp,index,self.currentFighters[camp][index].currentBox)
			self.fighterList[camp][index]["onStage"] = self.fighterList[camp][index]["onStage"] - 1
			table.insert(self.totalFighters[camp],fighterToAdd)

		end
	end

	local function sortFighters()

		local order = 1
		self.enemyOrder = {}
		for i=4,1,-1 do
			for j=4,1,-1 do
				for index,currentfighter in pairs(self.fighterList["Enemy"]) do

					if j==currentfighter.initPos[1] and i==currentfighter.initPos[2] then
						self.enemyOrder[order] = index
						order = order + 1
					end
				end
			end
		end
		print("enemyorder,",unpack(self.enemyOrder))

		order = 1
		self.friendOrder = {}

		for i=4,1,-1 do
			for j=5,8,1 do
				for index,currentfighter in pairs(self.fighterList["Friend"]) do
					print(currentfighter.initPos[1],currentfighter.initPos[2])
					if j==currentfighter.initPos[1] and i==currentfighter.initPos[2] then
						self.friendOrder[order] = index
						order = order + 1
					end
				end
			end
		end
		print("friendorder,",unpack(self.friendOrder))

	end

	local function updateFighterStatus(camp)
		print("updateFighterStatus being done")
		if self.fighterDead[camp] == self.totalFighterNumber[camp] then
			if camp == "Friend" then
				self.gameStatus = Macros.GameStatus.kGameOver
			else
				self.gameStatus = Macros.GameStatus.kGameWin
			end
		end
	end

	local function buffEffect()
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

	local function enemyMoveByOneBox (mover,index)
		local moveOver = false
		local curBox = mover.currentBox
		local curCor = curBox.coordinate
		print("move by one box:",curCor[1],curCor[2])
		print("mover on move,", mover.isFriend, mover.fighterName)
		if curCor[1] == Macros.FIGHTBOX_COLUMN then 
			print("gameover : move to end")
			self.pointEnemy = self.pointEnemy + self.point[curCor[2]]
			print(self.pointEnemy,self.point[curCor[2]],curCor[2])
			if self.point[curCor[2]] ~= 0 then
				self.pointCount = self.pointCount + 1
			end
			self.point[curCor[2]] = 0

			local t= "friend"
			if mover.isFriend == false then
				t = "enemy"
			end
			self.string = self.string.." "..t.."-"..mover.fighterName.."-"..curCor[2].." "
			-- self.gameStatus = Macros.GameStatus.kGameOver
			moveOver = true
			print("this should not be nil,",mover)
			-- mover = nil
			print(self.currentFighters["Enemy"][index].fighterName)
			self.currentFighters["Enemy"][index] = nil
			self.enemyFinished = self.enemyFinished + 1
			print("this should be nils,",mover)
			if not self.rowDone[curCor[2]] then
				self.rowDone[curCor[2]] = true
				self.rowFinished = self.rowFinished + 1
			end
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
				print("contenttype:",toMove.contentType, Macros.FIGHTBOX_ACCESSABLETYPE, toMove.currentFighter)
				if toMove.contentType < Macros.FIGHTBOX_ACCESSABLETYPE and not toMove.currentFighter then 
					print("can move directly")
					self:setCharacterDataToPosition(toMove, mover)
					curBox:setEmpty()
					self:addPlay(self.gameTime, function() return ({"playMoveToBox"}) end, {mover, "{"..toMovePos[1]..", "..toMovePos[2].."}" , true, 0.45, self.gameTime})
					self.gameTime = self.gameTime + 0.45

				elseif Formulas.getMovePreference(mover.calculatingParams) > 0 then 
					print("move pref",Formulas.getMovePreference(mover.calculatingParams))
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


	local function friendMoveByOneBox (mover, index)
		local moveOver = false
		local curBox = mover.currentBox
		local curCor = curBox.coordinate
		print("move by one box:",curCor[1],curCor[2])
		print("mover on move,", mover.isFriend, mover.fighterName)
		if curCor[1] == 1 then 
			print("gameover : move to end")
			-- self.gameStatus = Macros.GameStatus.kGameOver
			self.pointFriend = self.pointFriend + self.point[curCor[2]]
			if self.point[curCor[2]] ~= 0 then
				self.pointCount = self.pointCount + 1
			end
			self.point[curCor[2]] = 0
			local t= "friend"
			if mover.isFriend == false then
				t = "enemy"
			end
			self.string = self.string.."-"..t.."-"..mover.fighterName.."-"..curCor[2].." "
			print("this should not be nil,",mover.fighterName)
			-- mover = nil
			self.currentFighters["Friend"][index] = nil
			self.friendFinished = self.friendFinished + 1
			if not self.rowDone[curCor[2]] then
				self.rowDone[curCor[2]] = true
				self.rowFinished = self.rowFinished + 1
			end
			-- print("this should be nils,",mover )
			moveOver = true
		else
			local cannotmove = false
			if mover.buffAddon.Stun or mover.buffAddon.Freeze then
				cannotmove = true
			end
			if not cannotmove then

				local moveBy
				if mover.buffAddon.Chaos then
					moveBy = {1, 0}
				else
					moveBy = {-1, 0}
				end
				local toMovePos = curBox:getPosOfRelativeBox(moveBy)
				if toMovePos[1] == 0 then
					return true
				end
				print("to move pos:", mover.fighter.Information.Name, toMovePos[1],toMovePos[2])
				local toMove = self:getFightBoxByCoordinate(toMovePos)
				print("contenttype:",toMove.contentType, Macros.FIGHTBOX_ACCESSABLETYPE, toMove.currentFighter)
				if toMove.contentType < Macros.FIGHTBOX_ACCESSABLETYPE and not toMove.currentFighter then
					self:addPlay(self.gameTime, function() return ({"playMoveToBox"}) end, {mover, "{"..toMovePos[1]..", "..toMovePos[2].."}" , true, 0.45,self.gameTime})
					self.gameTime = self.gameTime + 0.45

					print("can move directly")
					self:setCharacterDataToPosition(toMove, mover)
					curBox:setEmpty()
				elseif Formulas.getMovePreference(mover.calculatingParams) > 0 then 
					print("move pref",Formulas.getMovePreference(mover.calculatingParams))
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


	local function setFightBoxes()
		for rowindex,row in pairs(self.ground) do
			for columnindex,boxtype in pairs(row) do
				local fightbox = FightBox.new()
				fightbox.battleField = self
				-- local xOffset = (columnindex - 0.5) * Macros.FIGHTBOX_WIDTH
				-- local yOffset = (rowindex - 0.5) * Macros.FIGHTBOX_HEIGHT
				-- fightbox:setPosition(xOffset, yOffset)
				-- print("fight box coordinate:", columnindex, rowindex)
				local coordinate = {columnindex, rowindex}
				fightbox.coordinate = coordinate
				-- self.fightBoxLayer:addChild(fightbox, 0)
				--用一张表记录格子，key为坐标值。
				self.fightBoxLayer.childrenlist[coordinate] = fightbox
				-- self.lsTouchHandler:addLsTouch(fightbox, coordinate)
				fightbox.contentType = boxtype
				-- print("boxtype:",boxtype)
				if columnindex > Macros.FIGHTBOX_MAX_ENEMY_COLUMN then -- mark
					fightbox.placeFriendAvailable = true
				end
			end
		end
	end


	local function fight()
		local forder = 1
		local eorder = 1
		local camp = "Friend"
		local turn = 0
		-- while self.gameStatus == Macros.GameStatus.kPlaying and self.pointCount ~= 4 and self.gameTurn ~=30 and self.friendFinished ~=5 and self.enemyFinished ~=5 do
		while self.gameStatus == Macros.GameStatus.kPlaying and self.pointCount ~= 4 and self.gameTurn ~=30 and self.friendFinished ~=5 and self.enemyFinished ~=5 and self.rowFinished ~=4 do
			
			turn = turn +1

			if camp == "Friend" then
				print ("self.frienddead",self.fighterDead[camp])
				print("A new turn!",camp)
				print("forder",forder)
				-- print(self.currentFighters[camp][5].fighterName)
				for i = 1,5 do
					print(self.currentFighters[camp][i])
				end

				while not (self.currentFighters[camp][self.friendOrder[forder]]) do
					forder = forder+1
					if forder == 6 then
						forder = 1
					end
					print("current forder,",forder)
				end
				local localfighter = self.currentFighters[camp][self.friendOrder[forder]]
				print("current fighter,",localfighter.fighterName)
				if localfighter.skillState.IsReadyToCastSuper then
					localfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(localfighter.fighter.SuperAtk.Speed + 90, localfighter.fighter.SuperAtk.Speed + 110)
				else
					localfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(localfighter.fighter.NormalAtk.Speed + 90, localfighter.fighter.NormalAtk.Speed + 110)
				end
				print ("localfighter.name",localfighter.fighterName)
				self:addProcess(self.gameTime,FighterInBattle.preCastSkill, {localfighter,self.gameTime})
				print("hey there - -|||")
				self:executeCastSkillFriend(localfighter)
				if self.playList[1] then
					self.gameTime = self.playList[#self.playList][1]
					self.playList = {}
				end
				-- print("number,",#self.playList)
				-- print("fsafsa,",self.playList[2][1])

				-- print(dump(self.playList))
				print("self.gameTimeFriend,",self.gameTime)
				-- print("fsafsa,",#self.playList)
				friendMoveByOneBox(localfighter,self.friendOrder[forder])


				forder = forder+1
				if forder == 6 then
					forder = 1
				end

				print("friend order,",forder)

			elseif camp == "Enemy" then
				print ("self.enemydead",self.fighterDead[camp])
				print("A new turn!",camp)

				print("An Enemy is found here!!!")
				for i = 1,5 do
					print(self.currentFighters[camp][i])
				end
				while not (self.currentFighters[camp][self.enemyOrder[eorder]]) do
					eorder = eorder + 1
					if eorder == 6 then
						eorder = 1
						self.gameTurn = self.gameTurn + 1
					end
					print(self.friendFinished,self.enemyFinished)
					print("curret eorderrrr,",eorder,self.enemyOrder[eorder],self.currentFighters[camp][self.enemyOrder[eorder]])
				end
				print("current eorder,",eorder)

				local localfighter = self.currentFighters[camp][self.enemyOrder[eorder]]
				print("current fighter,",localfighter.fighterName)
				print("flag here!!!",localfighter.fighterName)
				if localfighter.skillState.IsReadyToCastSuper then
					localfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(localfighter.fighter.SuperAtk.Speed + 90, localfighter.fighter.SuperAtk.Speed + 110)
				else
					localfighter.skillState.NextSkillPriority = Functions.RandomBetweenLowAndUp(localfighter.fighter.NormalAtk.Speed + 90, localfighter.fighter.NormalAtk.Speed + 110)
				end
				print ("localfighter.name",localfighter.fighterName)
				print ("self.gameTimeEnemy",self.gameTime)
				self:addProcess(self.gameTime,FighterInBattle.preCastSkill, {localfighter,self.gameTime})
				print("hey there - -|||")
				self:executeCastSkillEnemy(localfighter)
				if self.playList[1] then
					self.gameTime = self.playList[#self.playList][1]
					self.playList = {}
				end
				enemyMoveByOneBox(localfighter,self.enemyOrder[eorder])
				print("whether it is a nil,",localfighter)






				eorder = eorder + 1
				if eorder == 6 then
					eorder = 1
				end
				print("enemy order,",eorder)
			end
			if camp == "Enemy" then
				camp = "Friend"
			else
				camp = "Enemy"
			end

			self.processList = nil
			self.processList ={}

			updateFighterStatus("Friend")
			updateFighterStatus("Enemy")

		end

		-- local testt = dump(self.playPrintList)
		local c = #self.playPrintList
		testt = "{"
		for i=1,c do
			testt = testt..self.playPrintList[i]..","
		end
		testt = testt.."}"
		print("type",type(testt))
		-- skynet.error(testt)
		

		print("game turns, ",turn)
		print("gameTurn,",self.gameTurn)
		print("self.friendfinished,",self.friendFinished)
		print("self.enemyfinished,",self.enemyFinished)


	end





	initData()
	setFightBoxes()
	print("setFightBoxes succecced")
	initFighters("Friend")
	initFighters("Enemy")
	-- print(self.currentFighters["Friend"][1].pos[1],self.currentFighters["Friend"][1].pos[2])
	-- print(dump(self.currentFighters["Enemy"]))
	sortFighters()
	-- print(dump(self.fightorder))
	fight()
	print("friend,",self.pointFriend)
	print("enemy,",self.pointEnemy)
	print("pointcount,",self.pointCount)
	print(self.string)
	return testt

end


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

function FightScene:getFightBoxByTouchPoint( touchpoint )
	local x, y
	if touchpoint.x > self.originX then
		x,_ = math.modf((touchpoint.x - self.originX)/Macros.FIGHTBOX_WIDTH)+1
	else
		x = 0
	end
	if touchpoint.y>self.originY then
		y,_ = math.modf((touchpoint.y - self.originY)/Macros.FIGHTBOX_HEIGHT)+1
	else
		y = 0
	end
	return self:getFightBoxByCoordinate( {x,y} )
end

function FightScene:getFightBoxByCoordinate( cor )
	--通过坐标直接获得格子
	local ret = nil
	for k,v in pairs(self.fightBoxLayer.childrenlist) do
		if k[1] == cor[1] and k[2] == cor[2] then 
			ret = v
			break
		end
	end
	return ret
end
function FightScene:setCharacterToPosition( box, fighter )
	--角色形象和数据同时放在某个格子上
	self:setCharacterDataToPosition(box, fighter)
	-- self:setDisplayToPosition(box, fighter)
end
function FightScene:setCharacterDataToPosition( box, fighter )
	--只把角色数据绑定在某格子上，形象不移动过去
	fighter.currentBox = box
	box.currentFighter = fighter
end
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
function FightScene:moveCharacterToCurrent( fighter )
	-- print("movecharac------------------")
	--将角色移动到他数据所在的格子里，用到射影变换确定位置
	local curBox = fighter.currentBox
	local x, y = curBox:getPosition()
	x = x + self.originX
	y = y + self.originY
	xnew, ynew = transformPoint( x,y, "inverse" )
	xnew = xnew - self.originX
	ynew = ynew - self.originY
	local positionToMove = CCPoint(xnew,ynew)
	fighter:runAction(CCMoveTo:create(0.5,positionToMove))
	return 0.5
end
function FightScene:setBoxAccess()
	--对于拖起来的不同选手，设置不同的可达格子
	-- local moveability = self.dragSprite.fighter.Ability.MoveFriend + self.dragSprite.deltaAbility.MoveAbility
	local moveability = Formulas.getFriendMoveAblilty(self.dragSprite.calculatingParams)
	-- local moveability = 100
	if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
		moveability = 0
	end
	for i = 1, Macros.FIGHTBOX_COLUMN do
		for j = self.minRow, self.maxRow do
			local checkbox = self:getFightBoxByCoordinate({i,j})
			if not checkbox.placeFriendAvailable or checkbox.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE or (checkbox.currentFighter and not checkbox.currentFighter.isFriend) or moveability < checkbox:getDistanceToBox(self.dragSprite.startBox) then
				checkbox.accessable = false
			end
			checkbox:setVisualEffectNormal(self.dragSprite)
		end
	end 
end
function FightScene:resetBoxAccess()
	--假设所有格子都可达
	for i = 1, Macros.FIGHTBOX_COLUMN do
		for j = self.minRow, self.maxRow do
			local checkbox = self:getFightBoxByCoordinate({i,j})
			checkbox.accessable = true
			checkbox:setVisualEffectNormal()
		end
	end
end
function FightScene:onMoveBox( move, event )
	if move and move.accessable then 
		if ((move.placeFriendAvailable) and (move.contentType < Macros.FIGHTBOX_ACCESSABLETYPE) and (not move.currentFighter or move.currentFighter.isFriend)) then 
			-- print("onMoveBox: can place")
			--下面一长串都是设置攻击范围等的视觉效果
			local range = self.dragSprite.fighter.NormalAtk.Range
			if type(range) ~= "table" then
				range = Macros.FullScreen
			end
			if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
				range = {}
			end
			local firstTargetNotReachedNormal = true
			local firstTargetNotReachedNormalLast = true
			for rangekey,rangevalue in pairs(range) do
				local posOfBox = move:getPosOfRelativeBox(rangevalue)
				-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
				if posOfBox and posOfBox[1] ~= 0 then
					local boxToCheck = self:getFightBoxByCoordinate(posOfBox)
					if event == "In" then
						if boxToCheck.currentFighter and boxToCheck.currentFighter.isFriend == self.dragSprite.fighter.NormalAtk.ReceiverIsFriend then
							firstTargetNotReachedNormal = false
						end
						if firstTargetNotReachedNormal ~= firstTargetNotReachedNormalLast then
							boxToCheck:setVisualEffectAoe(self.dragSprite, rangekey, "hitbox")
							firstTargetNotReachedNormalLast = false
						else
							boxToCheck:setVisualEffectAoe(self.dragSprite, rangekey, firstTargetNotReachedNormal)
						end
					elseif event == "Out" or event == "Place" then 
						boxToCheck:setVisualEffectNormal(self.dragSprite)
					end
				end
			end
			if self.dragSprite.skillState.CoolDown == 0 then
				local range2 = self.dragSprite.fighter.SuperAtk.Range
				if type(range2) ~= "table" then
					range2 = Macros.FullScreen
				end
				if self.dragSprite.buffAddon.Stun or self.dragSprite.buffAddon.Freeze then
					range2 = {}
				end
				local firstTargetNotReachedSuper = true
				local firstTargetNotReachedSuperLast = true
				for rangekey,rangevalue in pairs(range2) do
					local posOfBox = move:getPosOfRelativeBox(rangevalue)
					-- print("第n个格子",rangekey)
					-- print("onMoveBox: posOfBox:",posOfBox[1],posOfBox[2])
					if posOfBox and posOfBox[1] ~= 0 then
						local boxToCheck = self:getFightBoxByCoordinate(posOfBox)
						if event == "In" then
							if boxToCheck.currentFighter and boxToCheck.currentFighter.isFriend == self.dragSprite.fighter.SuperAtk.ReceiverIsFriend then
								firstTargetNotReachedSuper = false
							end
							if firstTargetNotReachedSuper ~= firstTargetNotReachedSuperLast then
								boxToCheck:setVisualEffectSuper(self.dragSprite, rangekey, "hitbox")
								firstTargetNotReachedSuperLast = false
							else
								boxToCheck:setVisualEffectSuper(self.dragSprite, rangekey, firstTargetNotReachedSuper)
							end
						elseif event == "Out" or event == "Place" then 
							boxToCheck:setVisualEffectSuperNormal(self.dragSprite)
						end
					end
				end
			end
			if event == "In" then 
				-- print("onMoveBox: Move In, move.currentFighter!",move.currentFighter)
				move:setVisualEffectPlace()
			elseif event == "Out" or event == "Place" then 
				-- print("onMoveBox: Move Out!")
				move:setVisualEffectNormal(self.dragSprite)
			end
			-- print("onMoveBox: currentFighter: ",move.currentFighter)
			--如果格子里的人被晕了或者定身，行动值变0
			if move.currentFighter and move.currentFighter.isFriend then 
				-- print("onMoveBox: currentFighter: ",move.currentFighter)
				local moveability = Formulas.getFriendMoveAblilty(move.currentFighter.calculatingParams)
				-- local moveability = 100
				if move.currentFighter.buffAddon.Stun or move.currentFighter.buffAddon.Freeze then
					moveability = 0
				end
				-- for k,v in pairs(move.currentFighter.currentBuffs) do
				--             if k.buffType == "Stun" or k.buffType == "Freeze" then 
				--                            moveability = 0
				--             end
				-- end    
				if move.currentFighter ~= self.dragSprite then 
					if moveability >= move:getDistanceToBox(self.dragSprite.currentBox) then
						--格子里有人且能交换位置，则交换位置
						if event == "In" then 
							self:setDisplayToPosition(self.dragSprite.currentBox, move.currentFighter)
						elseif event == "Out" then 
							self:setDisplayToPosition(move.currentFighter.currentBox, move.currentFighter)
						elseif event == "Place" then 
							self:setCharacterToPosition(self.dragSprite.currentBox, move.currentFighter)
							self:setCharacterToPosition(move, self.dragSprite)
							self:newTurn()
						end
					elseif event == "Place" then 
						--如果要摆的格子里的人移动不了这么远，则放回原格子
						self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
					end
				elseif event == "Place" then
					--摆在自己原来的格子里，摆下就ok
					self:setCharacterToPosition(move, self.dragSprite)
				end
			elseif event == "Place" then 
				--摆在空格子里面，原格子设空
				self.dragSprite.currentBox:setEmpty()
				self:setCharacterToPosition(move, self.dragSprite)
				self:newTurn()
			end
		elseif event == "Place" then 
			--后面两项对应：结束点不在格子里或者格子不能摆东西，那么把拖动人物放回自己格子
			self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
		end
	elseif event == "Place" then 
		self:setDisplayToPosition(self.dragSprite.currentBox, self.dragSprite)
	end
end
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

--按时间不同自动插入列表位置
function FightScene:addProcess( time, func, parameters )
	print("addProcess time",time)

	if time == Macros.Instance then
		-- print("================================================================================================================================================================================")
		func(unpack(parameters))
		self:executeCastSkill(  )
	else
		if self.processList[1] == nil then
			print("self.processList[1]==nil")
			table.insert(self.processList, {time, func, parameters, 1})
			return 1
		else
			print("self.processlist[1]~=nil")
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
local flage= 0
function FightScene:addPlay( time, func, parameters )
	-- if time == Macros.Instance then
	-- 	func(unpack(parameters))
	-- else
	flage = flage+1

	print("time,",time)
	print("flage,",flage)
	print("parameters,",unpack(parameters))
	print("func,",func)
	print("unpack(parameters)",parameters[1],parameters[2],parameters[3],"end of parameters")
	-- print(func)
	local tem = func(unpack(parameters))
	print("#tem,",tem)
	local temp = tem[1]
	print("temp",temp)

		if self.playList[1] == nil then
			if temp == "playMoveToBox" then
			else
			table.insert(self.playList, {time, func, parameters})
			end
			-- if func == FighterInBattle.playCastSkill then
			-- 	print("matches")
			-- end
			-- local toInsert = "{"..time..", "..temp..", {"
			-- for _, par in pairs(parameters) do
			-- 	if type(par)=="string" then
			-- 		par = "\'"..par.."\'"
			-- 	end
			-- 	if type(par)=="table" then
			-- 		if par.fighterName then
			-- 			print("currenthero is",	par.fighterName)
			-- 			print("currenthero isornot a friend,",par.isFriend)
			-- 			local t = nil
			-- 			if par.isFriend == true then
			-- 				t = "defencer"
			-- 			elseif par.isFriend == false then
			-- 				t = "attacker"
			-- 			end
			-- 			par = "self.currentFighters."..t.."["..par.index.."]"
			-- 			-- par = par.fighterName
			-- 		else
			-- 			par = "not the self stuff"
			-- 		end

			-- 	end

			-- 	print(type(par))
			-- 	toInsert = toInsert..par..","
			-- end
			-- toInsert = string.sub(toInsert,1,-2)
			-- toInsert = toInsert.."}"
			-- table.insert(self.playPrintList, toInsert)
			local toInsert = nil
			local toInsertTemp = nil
			local toInsertt = "{"
			for _, par in pairs(parameters) do
				if type(par)=="string" and string.sub(par,1,1)~= "{" then
					par = "\'"..par.."\'"
				end
				if type(par)=="table" then
					if par.fighterName then
						print("currenthero is",	par.fighterName)
						print("currenthero isornot a friend,",par.isFriend)
						local t = nil
						if par.isFriend == true then
							t = "defencer"
						elseif par.isFriend == false then
							t = "attacker"
						end
						par = "self.currentFighters."..t.."["..par.index.."]"
						toInsertTemp = par
						print("fdslajflkdjsaflkdjsalfj,",toInsertTemp)
						-- par = par.fighterName
					else
						par = "self.battleField"
					end
				end
				if par == true then
					par = "true"
				elseif par == false then
					par = "false"
				end
				print(type(par))
				print(toInsertt)
				toInsertt = toInsertt..par..","

			end
			local toInsert = "{"..time..", "..toInsertTemp.."."..temp..", "..toInsertt
			toInsert = string.sub(toInsert,1,-2)
			toInsert = toInsert.."}}"
			table.insert(self.playPrintList, toInsert)

		else
			local pos = 1
			while self.playList[pos] and self.playList[pos][1] <= time do
				pos = pos + 1
			end
			table.insert(self.playList, pos, {time, func, parameters})
			local toInsert = nil
			local toInsertTemp = ""
			local toInsertt = "{"
			for _, par in pairs(parameters) do
				if type(par)=="string" and string.sub(par,1,1)~= "{"  then
					par = "\'"..par.."\'"
				end
				if type(par)=="table" then
					if par.fighterName then
						print("currenthero is",	par.fighterName)
						print("currenthero isornot a friend,",par.isFriend)
						local t = nil
						if par.isFriend == true then
							t = "defencer"
						elseif par.isFriend == false then
							t = "attacker"
						end
						par = "self.currentFighters."..t.."["..par.index.."]"
						toInsertTemp = par
						print (toInsertTemp)
						-- par = par.fighterName
					else
						par = "self.battleField"
					end
				end
				if par == true then
					par = "true"
				elseif par == false then
					par = "false"
				end
				print(type(par))
				toInsertt = toInsertt..par..","
			end
			local toInsert = "{"..time..", "..toInsertTemp.."."..temp..", "..toInsertt
			toInsert = string.sub(toInsert,1,-2)
			toInsert = toInsert.."}}"
			table.insert(self.playPrintList, toInsert)
		end
		-- print("self.playPrintList",dump(self.playPrintList))
	-- end
end

-- function FightScene:newTurn()
-- 	if not self.freeDrag then
-- 		if self.battleStatus == Macros.BattleStatus.kFriendMove and not self.scheduleExecutePlayList then
-- 			self.battleRatingSystem:newTurn()
-- 			Actions.Shake(self,1,2,1005)
-- 			self.battleStatus = Macros.BattleStatus.kBuffEffect
-- 		end
-- 	end
-- end

return FightScene