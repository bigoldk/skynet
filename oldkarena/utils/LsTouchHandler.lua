local LsTouchHandler = class("LsTouchHandler")
local Macros = import(".Macros")
function LsTouchHandler:ctor(  )
	print("hello LsTouchHandler !")
	self.m_pLsTouches = {}
end
function LsTouchHandler:addLsTouch( touch, eventId )
	touch:setEventId(eventId)
	table.insert(self.m_pLsTouches, touch)
end
function LsTouchHandler:removeLsTouch( touch )
	for k,v in pairs(self.m_pLsTouches) do
		if v == touch then 
			table.remove(self.m_pLsTouches, k)
			break 
		end
	end
end

function LsTouchHandler:getPriorityTouch( a, b )
	local allParent
	local nAParent = a
	local nBParent = b
	local nAChild, nBChild
	print("getPriorityTouch: a, b = ", nAParent, nBParent)
	while true do
		nAChild = nAParent
		nAParent = nAParent:getParent()
		if not nAParent then 
			break 
		end
		nBParent = b
		while true do
			nBChild = nBParent
			nBParent = nBParent:getParent()
			if not nBParent then 
				break 
			end
			if nAParent == nBParent then 
				allParent = nAParent
				break
			end
			if nBParent == self then 
				break 
			end
		end
		if allParent then 
			break
		end
		if nAParent == self then 
			break 
		end
	end
	if (not nAChild) or (not nBChild) then 
		return a 
	elseif nAChild:getZOrder() == nBChild:getZOrder() then 
		return ((allParent:getChildren():indexOfObject(nAChild) > allParent:getChildren():indexOfObject(nBChild)) and a) or b
	else
		return ((nAChild:getZOrder() > nBChild:getZOrder()) and a) or b	
	end
end
function LsTouchHandler:sendTouchMessage( targetscene, cctouch, touchtype )
	local lsTouch
	for key, obj in pairs(self.m_pLsTouches) do
		if obj then 
			if obj:selfCheck( cctouch ) then 
				 --print("in lstouch event , key = ", key)
				if not lsTouch then 
					lsTouch = obj
				
				else 
					lsTouch = self:getPriorityTouch(lsTouch, obj)

				end
			end
		end
	end
	targetscene:touchEventAction(lsTouch, touchtype)
	return true
end
return LsTouchHandler