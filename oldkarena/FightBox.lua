-- Author: Yiran WANG

-- local LsTouch = import("..utils.LsTouch")
local FightBox = class("FightBox")
local Macros = require "Macros"
local CURRENT_MODULE_NAME = ...

function FightBox:ctor()
	-- print("hello fightbox")
	self.accessable = true
	self.coordinate = nil
	-- self:setDisplay(CCSprite:create("FightBox.png"))
	-- show:setOpacity(0)
	-- self:getDisplay():setOpacity(0)
	self.placeFriendAvailable = false
	self:setEmpty()
	-- self:setVisualEffectNormal()
	-- self:setVisualEffectSuperNormal()
	-- print("bye fightbox")
end
function FightBox:getPosOfRelativeBox( relativeCor )
	local returnX = self.coordinate[1] + relativeCor[1]
	local returnY = self.coordinate[2] + relativeCor[2]
	if returnX < 1 or returnY < 1 or returnX > Macros.FIGHTBOX_COLUMN or returnY > Macros.FIGHTBOX_ROW then 
		return {0, 0}
	else 
		return {returnX, returnY}
	end
end
-- function FightBox:setVisualEffectPlace(  )
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(255,255,255))
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(192)
-- end
-- function FightBox:setVisualEffectAoe( checkingFighter, rangenumber, targetnotreached )
-- 	if not (checkingFighter.fighter.NormalAtk.SpecialBoxEffect and checkingFighter.fighter.NormalAtk.SpecialBoxEffect == rangenumber) then
-- 		if not (checkingFighter.fighter.NormalAtk.HitType ==  Macros.SkillHitType.eFlying and targetnotreached == false) then
-- 			local skillToCheck = checkingFighter.skillState.IsReadyToCastSuper and checkingFighter.fighter.SuperAtk or checkingFighter.fighter.NormalAtk
-- 			if skillToCheck.ReceiverIsFriend then
-- 				self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(0,255,0))
-- 			else
-- 				self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(255,0,0))
-- 			end
-- 			self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(192)
-- 			if targetnotreached == "hitbox" and checkingFighter.fighter.NormalAtk.SpecialBoxEffectAtHitbox then
-- 				local checkingScripts = import("..fighterscripts."..checkingFighter.fighterName.."Script", CURRENT_MODULE_NAME)
-- 				checkingScripts.setBoxSpecialEffect(self, "Normal", "hitbox")
-- 			end
-- 		end
-- 	else
-- 		local checkingScripts = import("..fighterscripts."..checkingFighter.fighterName.."Script", CURRENT_MODULE_NAME)
-- 		checkingScripts.setBoxSpecialEffect(self, "Normal", rangenumber)
-- 	end
-- end
-- function FightBox:setVisualEffectItem( ItemInfo )
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(0,255,0))
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(192)
-- end
-- function FightBox:setVisualEffectSuper( checkingFighter, rangenumber, targetnotreached )
-- 	if not (checkingFighter.fighter.SuperAtk.SpecialBoxEffect and checkingFighter.fighter.SuperAtk.SpecialBoxEffect == rangenumber) then
-- 		if not (checkingFighter.fighter.SuperAtk.HitType ==  Macros.SkillHitType.eFlying and targetnotreached == false) then
-- 			local skillToCheck = checkingFighter.fighter.SuperAtk
-- 			if skillToCheck.ReceiverIsFriend then
-- 				self:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setColor(ccc3(0,255,0))
-- 			else
-- 				self:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setColor(ccc3(255,0,0))
-- 			end
-- 			self:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setOpacity(64)
-- 			if targetnotreached == "hitbox" and checkingFighter.fighter.SuperAtk.SpecialBoxEffectAtHitbox then
-- 				local checkingScripts = import("..fighterscripts."..checkingFighter.fighterName.."Script", CURRENT_MODULE_NAME)
-- 				checkingScripts.setBoxSpecialEffect(self, "Super", "hitbox")
-- 			end
-- 		end
-- 	else
-- 		local checkingScripts = import("..fighterscripts."..checkingFighter.fighterName.."Script", CURRENT_MODULE_NAME)
-- 		checkingScripts.setBoxSpecialEffect(self, "Super", rangenumber)
-- 	end
-- end
-- function FightBox:setVisualEffectNormal( fighter )
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setColor(ccc3(0,0,0))
-- 	if self.accessable then
-- 		self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(0)
-- 	else
-- 		self:getChildByTag(Macros.FIGHTBOX_SHOWTAG):setOpacity(128)
-- 	end
-- 	if self.specialNeedToRemove then
-- 		local checkingScripts = import("..fighterscripts."..fighter.fighterName.."Script", CURRENT_MODULE_NAME)
-- 		checkingScripts.removeBoxSpecialEffect(self, self.specialNeedToRemove[1], self.specialNeedToRemove[2])
-- 	end
-- end
-- function FightBox:setVisualEffectSuperNormal()
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setColor(ccc3(0,0,0))
-- 	self:getChildByTag(Macros.FIGHTBOX_SHOW2TAG):setOpacity(0)
-- end
function FightBox:setEmpty(  )
	-- self.contentType = 0
	self.currentFighter = nil
end
function FightBox:getDistanceToBox( targetBox )
	local targetCoordinate = targetBox.coordinate
	local currentCoordinate = self.coordinate
	return math.abs(currentCoordinate[1] - targetCoordinate[1]) + math.abs(currentCoordinate[2] - targetCoordinate[2])
end
return FightBox