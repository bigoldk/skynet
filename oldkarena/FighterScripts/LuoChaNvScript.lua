--
-- Author: Yiran WANG
-- Date: 2014-11-05 18:23:47
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
local LuoChaNv = class("LuoChaNv", FighterInBattle)

function LuoChaNv:ctor()
	FighterInBattle.ctor(self)
end

function LuoChaNv:getDisplaceBox(skillToCast, receiver)
	boxToSet = receiver.currentBox
	for i=1,15 do
		local boxToSetNextPos
		if receiver.isFriend then
			boxToSetNextPos = boxToSet:getPosOfRelativeBox({1,0})
		else
			boxToSetNextPos = boxToSet:getPosOfRelativeBox({-1,0})
		end
		local boxToSetNext = self.battleField:getFightBoxByCoordinate(boxToSetNextPos)
		if (not boxToSetNext) or boxToSetNext.currentFighter or boxToSetNext.contentType >= Macros.FIGHTBOX_ACCESSABLETYPE then
			-- print("break at", i)
			break
		else
			boxToSet = boxToSetNext
		end
	end
	return boxToSet
end

return LuoChaNv