local LsTouch = class("LsTouch", function() return CCNode:create() end)

local TAG_DISPLAY = 100
function LsTouch:ctor(  )
	print("hello LsTouch !")
	self.m_iEventId = {0,0}
end
function LsTouch:containsCCTouchPoint( ccTouch )
	local sprite = self:getChildByTag(TAG_DISPLAY)
	local point = sprite:convertToNodeSpaceAR(ccTouch)
	local s = sprite:getTexture():getContentSize()
	local anchor = sprite:getAnchorPoint()
	local rect = CCRectMake(-s.width * anchor.x, -s.height * anchor.y, s.width, s.height)
	return rect:containsPoint(point)
end
function LsTouch:setDisplay( dis )
	if self:getChildByTag(TAG_DISPLAY) then
		self:removeChildByTag(TAG_DISPLAY,true)
	end
	self:addChild(dis, 0, TAG_DISPLAY)
end
function LsTouch:getDisplay(  )
	return self:getChildByTag(TAG_DISPLAY)
end
function LsTouch:setEventId( eventId )
	self.m_iEventId = eventId
end
function LsTouch:getEventId(  )
	return self.m_iEventId
end
function LsTouch:selfCheck( ccTouch )
	local bRef = true
	if not self:containsCCTouchPoint(ccTouch) then 
		bRef = false 
	elseif not self:isRunning() then 
		bRef = false 
	elseif not self:isVisible() then 
		bRef = false
	end
	return bRef
end
return LsTouch