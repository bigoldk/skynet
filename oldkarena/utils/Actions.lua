-- By Yi Feng
-- 封装了一些自定义的动作
local Actions = {}

-- swap 在dt内交换节点1和节点2的位置
-- @parms: a  节点1
--         b  节点2
--         dt 所需要的时间

function Actions.swap(a,b,dt)    
	local pt_ax,pt_ay = a:getPosition()
	local pt_bx,py_ay = b:getPosition()
	
	transition.moveTo(a,{x=pt_bx,y=pt_by,time=dt})
	transition.moveTo(b,{x=pt_ax,y=pt_ay,time=dt})
end

-- replace 在dt内用节点2取代节点1，即交换节点1和节点2的位置，
-- 节点2在节点1之上
-- @parms: a  节点1
--         b  节点2
--         dt 所需要的时间

function Actions.replace(a,b,dt)    -- using b instead of a, i.e. b is over a and them exchange position
	local pt_ax,pt_ay = a:getPosition()
	local pt_bx,py_ay = b:getPosition()
	local zorder_a = a:getZOrder()
	local zorder_b = b:getZOrder()
	
	a:setZOrder(zorder_b)
	b:setZOrder(zorder_a)
	
	transition.moveTo(a,{x=pt_bx,y=pt_by,time=dt})
	transition.moveTo(b,{x=pt_ax,y=pt_ay,time=dt})
end

-- CoverFullScreen 在dt内让特定的精灵覆盖全屏
-- @parms: a  精灵
--         dt 所需要的时间

function Actions.CoverFullScreen(a,dt)
	local win_x = CCDirector:sharedDirector():getWinSize().width
	local win_y= CCDirector:sharedDirector():getWinSize().height
    local scale_y = win_x/a:getContentSize().height
    local scale_x = win_y/a:getContentSize().width
    --缩放
    transition.scaleTo(a,{scaleX=scale_x,scaleY=scale_y,time=dt})
    --平移
	transition.moveTo(a,{x=win_x/2,y=win_y/2,time=dt})
	--旋转 
	transition.rotateTo(a,{rotate=-90,time=dt})
end
function Actions.OutInOut(a)
	local scale = a:getScale()
	local out1 = CCScaleTo:create(0.15,1.2*scale)
	local in1 = CCScaleTo:create(0.07,0.9*scale)
	local out2 = CCScaleTo:create(0.07, 1.1*scale)
	local in2 = CCScaleTo:create(0.07,1.0*scale)
	local action = transition.sequence({out1,in1,out2,in2})
	transition.execute(a,action,{delay = 0.0})
end

function Actions.InOutIn(a)
	local scale = a:getScale()
	--local out1 = CCScaleTo:create(0.1,1.05*scale)
	local in1 = CCScaleTo:create(0.1,0.9*scale)
	local out1 = CCScaleTo:create(0.1, 1.05*scale)
	local in2 = CCScaleTo:create(0.1,0.9*scale)
    local out2 = CCScaleTo:create(0.1, 1.0*scale)
	local action = transition.sequence({in1,out1,in2,out2})
	transition.execute(a,action,{delay = 1.0})
end

function Actions.Shake(a,dt,frequency,strengthx,strengthy)
	local params = {
		duration = dt,
		strengthX = strengthx,
		strengthY = strengthY,
		frequency = frequency,
	}
	local Shake = SNShake.new(params)
	local callfunc = SNCallFunc.new({func = function(string) print(string) end, params = {"lalalalla"}})
	local sequence = SNSequence.new({Shake,callfunc})
	sequence:startWithTarget(a)
end

function Actions.bezierToPoint(node,parameters)
	local bezier=ccBezierConfig();
    bezier.controlPoint_1 = CCPoint(0.5*parameters.x, 0)
    bezier.controlPoint_2 = CCPoint(parameters.x,0.5*parameters.y)
    bezier.endPosition = CCPoint(parameters.x, parameters.y)
    transition.execute(node,
    	               CCBezierBy:create(1.5,bezier),
    	               {easing = "sineIn",
    	               onComplete = function()
    	                            print("removed!")
                                    node:removeSelf()
                                    -- we need to do sth here 
                                    parameters.storehouse:removeSelf()
                                    end
                        }
                       )
end
return Actions