--
-- Author: Yiran WANG
-- Date: 2014-09-02 18:43:22

--quick

local class = require "class"
local BattleRatingSystem = class("BattleRatingSystem")

local function getLevelInformation(self, battlefield, camp)
	local maxLevel = 0
	local totalLevel = 0
	local totalCharacter = 0 
	for k,v in pairs(battlefield.fighterList[camp]) do
		if v.Fighter.Level > maxLevel then
			maxLevel = v.Fighter.Level
		end
		totalLevel = totalLevel + v.Fighter.Level
		totalCharacter = totalCharacter + 1
	end
	self.maxLevel[camp] = maxLevel
	self.averageLevel[camp] = totalLevel/totalCharacter
end

function BattleRatingSystem:ctor( battlefield )
	self.battlefield = battlefield
	self.turns = 0
	self.maxLevel = {Friend = 0, Enemy = 0}
	self.averageLevel = {Friend = 0, Enemy = 0}
	self.totalDamageReceived = {Friend = 0, Enemy = 0}
	self.totalDamageReceivedTimes = {Friend = 0, Enemy = 0}
	self.totalDamageDealt = {Friend = 0, Enemy = 0}
	self.totalHealthRestored = {Friend = 0, Enemy = 0}
	self.totalEnemiesKnockedOut = {Friend = 0, Enemy = 0}
	self.enemyPassLines = 0

	self.totalTime = 0
	self.maxCombo = 0
end

function BattleRatingSystem:newTurn(  )
	self.turns = self.turns + 1
end

local function getFightInformation( self,battlefield, camp )
	local totaldamagereceived = 0
	local totaldamagetimes = 0
	local totaldamagedealt = 0
	local totalhealthrestored = 0
	local totalenemiesknockedout = 0
	local enemypasslines = 0
	for k,v in pairs(battlefield.totalFighters[camp]) do
		totaldamagereceived = totaldamagereceived + v.statManager:getStat("damageReceived")
		totaldamagetimes = totaldamagetimes + v.statManager:getStat("damageReceivedTimes")
		totaldamagedealt = totaldamagedealt + v.statManager:getStat("damageDealt") + v.statManager:getStat("buffsMade").Poison + v.statManager:getStat("buffsMade").Bleeding
		totalhealthrestored = totalhealthrestored + v.statManager:getStat("healthRestored") + v.statManager:getStat("buffsMade").ContinuingHeal
		totalenemiesknockedout = totalenemiesknockedout + v.statManager:getStat("enemiesKnockedOut")
		if camp == "Enemy" then
			enemypasslines = enemypasslines + v.statManager:getStat("finalPassLines")
		end
	end
	self.totalDamageReceived[camp] = totaldamagereceived
	self.totalDamageReceivedTimes[camp] = totaldamagetimes
	self.totalDamageDealt[camp] = totaldamagedealt
	self.totalHealthRestored[camp] = totalhealthrestored
	self.totalEnemiesKnockedOut[camp] = totalenemiesknockedout	
	if camp == "Enemy" then
		self.enemyPassLines = enemypasslines
	end
end

local function getRatingInformation (self, battlefield)
	getLevelInformation(self, battlefield, "Friend")
	getLevelInformation(self, battlefield, "Enemy")
	getFightInformation(self, battlefield, "Friend")
	getFightInformation(self, battlefield, "Enemy")
	self.totalTime = battlefield.gameTime
	self.maxCombo = battlefield.comboManager:getMaxCombo()
end

function BattleRatingSystem:rate(  )
	getRatingInformation(self, self.battlefield)
	print("turns",self.turns)
	print("maxLevel",self.maxLevel.Friend,self.maxLevel.Enemy)
	print("averageLevel",self.averageLevel.Friend,self.averageLevel.Enemy)
	print("totalDamageReceived",self.totalDamageReceived.Friend,self.totalDamageReceived.Enemy)
	print("totalDamageReceivedTimes",self.totalDamageReceivedTimes.Friend,self.totalDamageReceivedTimes.Enemy)
	print("totalDamageDealt",self.totalDamageDealt.Friend,self.totalDamageDealt.Enemy)
	print("totalHealthRestored",self.totalHealthRestored.Friend,self.totalHealthRestored.Enemy)
	print("totalEnemiesKnockedOut",self.totalEnemiesKnockedOut.Friend,self.totalEnemiesKnockedOut.Enemy)
	print("enemyPassLines",self.enemyPassLines)
	print("totalTime",self.totalTime)
	print("maxCombo",self.maxCombo)
end

return BattleRatingSystem