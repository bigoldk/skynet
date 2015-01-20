--
-- Author: Yiran WANG
-- Date: 2014-08-27 13:36:17

--quick

--作用：处理发送来的连击信息（倒计时，重置，停止，暂停etc），状态（是否接受连击）。
--可以返回当前连击数，最大连击数
--
local Macros = require "Macros"
local ComboManager = class("ComboManager")

function ComboManager:ctor(battleField)
	self.battleField = battleField
	self.remainTime = Macros.ComboTolerenceTime
	self.receiveCombo = true
	self.receiveDisplayCombo = true
	self.maxCombo = 0
	self.currentCombo = 0
	self.displayMaxCombo = 0
	self.displayCurrentCombo = 0
	self.timer = true
	self.label = nil
end

function ComboManager:addCombo(combotype, time)
	print("add combo!")
	local currentCombo
	local countToAdd
	if combotype == "display" then
		print("combotype == display")
		if not self.receiveDisplayCombo then
			print("there should be a return here")
			return {"self.battleField.comboManager.addCombo",false}
		end
		self.displayCurrentCombo = self.displayCurrentCombo + 1
		currentCombo = self.displayCurrentCombo
		if self.displayCurrentCombo > self.displayMaxCombo then
			self.displayMaxCombo = self.displayCurrentCombo
			print("hey i'm here")
		end
		-- self.label:repop()
		-- print ("display combo", self.displayCurrentCombo, self.displayMaxCombo)
	else
		print("combotype ~= display")
		if not self.receiveCombo then
			return {"self.battleField.comboManager.addCombo",false}
		end
		self.currentCombo = self.currentCombo + 1
		currentCombo = self.currentCombo
		if self.currentCombo > self.maxCombo then
			self.maxCombo = self.currentCombo
		end
		-- print ("combo", self.currentCombo, self.maxCombo)
	end
	if currentCombo % 100 == 0 then
		countToAdd = 100
	elseif currentCombo % 50 == 0 then
		countToAdd = 50
	elseif currentCombo % 10 == 0 then
		countToAdd = 10
	else
		countToAdd = 1
	end
	print ("time is ", time)
	-- self.battleField.feverBar:setCountBy(countToAdd, combotype, time)
	return {"self.battleField.comboManager.addCombo"}
end

function ComboManager:getCurrentCombo(combotype)
	if combotype == "display" then
		return self.displayCurrentCombo
	else
		return self.currentCombo
	end
end

function ComboManager:getMaxCombo(combotype)
	if combotype == "display" then
		return self.displayMaxCombo
	else
		return self.maxCombo
	end
end

function ComboManager:clearCombo(combotype)
	if combotype == "display" then
		self.displayCurrentCombo = 0
	else
		self.currentCombo = 0
	end
end

function ComboManager:setReceiveComboEnable(enabled, combotype)
	if combotype == "display" then
		self.receiveDisplayCombo = false
	else
		self.receiveCombo = false
	end
end

function ComboManager:startTimer()
	self.label:fadeOut(self.remainTime)
	self.timer = true
end

function ComboManager:pauseTimer()
	self.label:setNormal()
	self.timer = false
end

function ComboManager:setTimer(remaintime)
	assert(remaintime >= 0, "remaining time should be non-negative")
	self.remainTime = remaintime
end

function ComboManager:resetTimer()
	self:setTimer(Macros.ComboTolerenceTime)
end

function ComboManager:stopTimer()
	self.timer = false
	self:resetTimer()
end

function ComboManager:passTime(time)
	assert(time >= 0, "time passed should be non-negative")
	if self.timer then
		self.remainTime = self.remainTime - time
		if self.remainTime < 0 then
			self:clearCombo()
			self:clearCombo("display")
			self:stopTimer()
		end
	end
end

return ComboManager