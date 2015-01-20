--
-- Author: Yiran WANG
-- Date: 2014-09-01 09:32:39
--
--
local class = require "class"
local Macros = require "Macros"
local StatManager = class("StatManager")

function StatManager:ctor(fighter)
	self.fighter = fighter
	self.damageReceived = 0
	self.damageReceivedTimes = 0
	self.damageDealt = 0
	self.healthRestored = 0
	self.enemiesKilled = 0
	self.enemiesKnockedOut = 0
	self.buffsMade = {
		Stun = 0,
		Freeze = 0,
		Disarm = 0,
		Poison = 0,
		Bleeding = 0,
		ContinuingHeal = 0,
	}
	self.bossKilled = 0
	self.criticalAttackMade = 0
	self.finalPassLines = 0
	-- print("fjdlkajflkdjsalkfjdlakjfldjslkafjjfkldsjf")
end

function StatManager:setFinalPassLines( lines )
	self.finalPassLines = lines
end

function StatManager:receiveDamage(damage)
	self.damageReceived = self.damageReceived +damage
	self.damageReceivedTimes = self.damageReceivedTimes + 1
end

function StatManager:restoreHealth(heal)
	self.healthRestored = self.healthRestored + heal
end

function StatManager:dealDamage(damage)
	self.damageDealt = self.damageDealt + damage
end

function StatManager:killEnemy(enemy)
	self.enemiesKilled = self.enemiesKilled + 1
	if enemy.notacted then
		self.enemiesKnockedOut = self.enemiesKnockedOut + 1
	end
	if enemy.isboss then
		self.bossKilled = self.bossKilled + 1
	end
end

function StatManager:CriticalAttack()
	self.criticalAttackMade = self.criticalAttackMade + 1
end

function StatManager:buffsMadeByTurns(bufftype)
	self.buffsMade[bufftype] = self.buffsMade[bufftype] + 1
end

function StatManager:buffsMadeByValue(bufftype, value)
	self.buffsMade[bufftype] = self.buffsMade[bufftype] + value
end

function StatManager:getStat(stat)
	return self[stat]
end

return StatManager