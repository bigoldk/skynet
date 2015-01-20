--
-- Author: Yiran WANG
-- Date: 2014-08-05 16:18:35
--
local Formulas = require "Formulas"
local Macros = require "Macros"
local F_FeverBar = class("F_FeverBar")

function F_FeverBar:ctor ( params )
	-- self.Progress = {} 
	-- self.fullPercentage = params.fullPercentage or 100
	-- self.emptyPercentage = params.emptyPercentage or 0
	-- print("percentage",self.Progress:getPercentage())
	local x = params.x or 0
	local y = params.y or 0
	self:setPosition(x,y)
	self.comboParams = params.comboParams
	self.totalSections = #self.comboParams.capacity
	-- for i=1,self.totalSections do
	-- 	self.Progress[i] = display.newProgressTimer(params.fileName, kCCProgressTimerTypeBar)
	-- 	self.Progress[i]:setBarChangeRate(ccp(1, 0))
	-- 	self.Progress[i]:setZOrder(100 - i)
	-- 	self:addChild(self.Progress[i])
	-- end
	self.totalCounts = self.comboParams.capacity[#self.comboParams.capacity]
	self.displayCounts = 0
	self.counts = 0
	self.currentSection = 0
	self.displayCurrentSection = 0
	local xulicao = display.newSprite("xuLi0.png")
	self.size = xulicao:getContentSize()
	local PUSH_BUTTON_IMAGES = {
	    -- normal = "Button01.png",
	    -- pressed = "Button01Pressed.png",
	    -- disabled = "Button01Disabled.png",
	    -- altered by Yi
	    normal = "xuLi3.png",
	    pressed = "xuLi1.png",
	    disabled = "xuLi0.png"
	}
	self.releaseButton = cc.ui.UIPushButton.new(PUSH_BUTTON_IMAGES, {scale9 = true})
        :setButtonSize(self.size.width,self.size.height)
        -- :setButtonLabel("normal", ui.newTTFLabel({
        --     text = "Normal",
        --     size = 18
        -- }))
        -- :setButtonLabel("pressed", ui.newTTFLabel({
        --     text = "Pressed",
        --     size = 18,
        --     color = ccc3(255, 64, 64)
        -- }))
        -- :setButtonLabel("disabled", ui.newTTFLabel({
        --     text = "Disabled",
        --     size = 18,
        --     color = ccc3(0, 0, 0)
        -- }))
        :onButtonClicked(function(event)
        	self:releaseCounts()
        end)
        :align(display.LEFT_CENTER, 0, 0)
        :addTo(self)
	-- self:setPercentage(0)
	self:refreshButtonState()
	self.battleField = params.battleField
	self:setTouchCaptureEnabled(true)
end

function F_FeverBar:setCountBy(count, counttype, time)
	if counttype == "display" then
		self.displayCounts = self.displayCounts + count
		if self.displayCounts < 0 then
			self.displayCounts = 0
		elseif self.displayCounts > self.totalCounts then
			self.displayCounts = self.totalCounts
		end
		local sectionBefore = self.displayCurrentSection
		local newSection = self:getSectionByCounts(self.displayCounts)
		if newSection ~= sectionBefore then
			print("new section!", newSection)
			self.displayCurrentSection = newSection
		end
		self:refreshButtonState()
	else
		self.counts = self.counts + count
		if self.counts < 0 then
			self.counts = 0
		elseif self.counts > self.totalCounts then
			self.counts = self.totalCounts
		end
		local sectionBefore = self.currentSection
		local newSection = self:getSectionByCounts(self.counts)
		if newSection ~= sectionBefore then
			print("new section at", time)
			self.currentSection = newSection
			self.battleField:refreshFeverBuff(time)
		end
	end			
end

function F_FeverBar:refreshButtonState()
	if self.displayCurrentSection == self.totalSections then
		print("set button enable")
		self.releaseButton:setButtonEnabled(true)
	else
		print("set button disable")
		self.releaseButton:setButtonEnabled(false)
	end
end

function F_FeverBar:releaseCounts(  )
	if self.comboParams.release.releaseType == "damage" then
		local totalDamage = 0
		for index, checkfighter in pairs(self.battleField.currentFighters["Friend"]) do
			totalDamage = totalDamage + Formulas.getBaseValue(checkfighter.calculatingParams, "Atk") * (1 + Formulas.getRatioValue(checkfighter.calculatingParams, "Atk"))
		end
		for index, checkfighter in pairs(self.battleField.currentFighters["Enemy"]) do
			self.battleField:addProcess(Macros.Instance, checkfighter.changeCurrentHpBy, {checkfighter, -totalDamage * self.comboParams.release.releaseValue, Macros.Instance})
		end
	else
		for index, checkfighter in pairs(self.battleField.currentFighters["Friend"]) do
			self.battleField:addProcess(Macros.Instance, checkfighter.changeCurrentHpBy, {checkfighter, checkfighter.totalHp * self.comboParams.release.releaseValue, Macros.Instance})
		end
	end
	self:playReleaseAnimation()
	self:setCountBy(-self.totalCounts, "value", Macros.Instance)
	self:setCountBy(-self.totalCounts, "display")
end

function F_FeverBar:playReleaseAnimation()

end

function F_FeverBar:getSectionByCounts(counts)
	local section = 0
	for i=1,self.totalSections do
		if counts >= self.comboParams.capacity[i] then
			section = i
		end
	end
	return section
end

-- function F_FeverBar:setPercentage( percentage )
-- 	local convertedPercentage = self.emptyPercentage + (self.fullPercentage - self.emptyPercentage) * percentage
-- 	self.Progress:setPercentage(convertedPercentage)
-- end

return F_FeverBar

