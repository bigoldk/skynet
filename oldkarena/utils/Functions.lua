-- local UI_FlyString = import("..ui.UI_FlyString")
-- local NotEnoughResource = import("..farmItems.NotEnoughResource")
-- local Food = import("..farmItems.Food")
local Functions = {}
function Functions.CreateEnumTable( tbl, index )
	assert(type(tbl) == "table") 
	local enumtbl = {} 
	local enumindex = index or 0 
	for i, v in ipairs(tbl) do 
		enumtbl[v] = enumindex + i 
	end 
	return enumtbl 
end
function Functions.RatioCalculator( ratio )
	return math.max(ratio, 0)/100
end
function Functions.RandomBetweenLowAndUp( low, up, isinteger )
	local nRet
	nRet = math.random() * (up - low) + low
	if isinteger == "integer" then
		nRet = math.floor (nRet)
	end
	return nRet
end
function Functions.Xor(a, b)
  return (a and not b) or (b and not a)
end

function Functions.calculateProb(x)
  return 30-300/(0.001*x*x+0.001*x+10)
  
end

--从列表中随机选出N项返回
function Functions.GetCombination( toChooseList, selectNumber )
	local totalNumber = #toChooseList
	if selectNumber >= totalNumber then
		return toChooseList
	end
	local m = totalNumber 
	local n = selectNumber
	local chosenList = {}
	for i=1,totalNumber do
		local random = Functions.RandomBetweenLowAndUp( 0, 1 )
		if Functions.RandomBetweenLowAndUp( 0, 1 ) < n/m then
			table.insert(chosenList, toChooseList[i])
			print ("Chosen", i)
			n = n - 1
		end
		m = m - 1
	end
	return chosenList
end

function Functions.getInteger( number )
	return math.floor(number + 0.5)
end
-- AddPopupListener 添加一个点击出现松手消失的事件
-- @parms: 	target 		要添加的对象
--			popup 		popup的名字
--			x, y 		popup出现的位置
--			parameters 	参数列表table
function Functions.AddPopupListener( target, popup, x, y, parameters )
	target:setTouchEnabled(true)
	target.PopupClass = require("app.ui."..popup)
	local function onTouch( event )
		if event.name == "began" then
			target.popup = target.PopupClass.new(parameters)
			target.popup:setPosition(cc.Point(x,y))
			target:addChild(target.popup)
			return true
		elseif event.name == "moved" then 
			-- print("point moved")
		elseif event.name == "ended" then
			if target.popup then
				--target.popup:removeFromParent()
			    target.popup:CloseWithAction()
			end
		elseif event.name == "canceled" then
			if target.popup then
				target.popup:removeFromParent()
			end
		end
	end
	target:addNodeEventListener(cc.NODE_TOUCH_EVENT,onTouch)
end

function Functions.serialize(obj)  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{\n"  
    for k, v in pairs(obj) do  
        lua = lua .. "[" .. Functions.serialize(k) .. "]=" .. Functions.serialize(v) .. ",\n"  
    end  
    local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
        for k, v in pairs(metatable.__index) do  
            lua = lua .. "[" .. Functions.serialize(k) .. "]=" .. Functions.serialize(v) .. ",\n"  
        end  
    end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    else  
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua
end  
  
function Functions.unserialize(lua)  
    local t = type(lua)
    -- print(lua)
    -- print("type of luastring", t)
    if t == "nil" or lua == "" then  
        return nil  
    elseif t == "number" or t == "string" or t == "boolean" then  
        lua = tostring(lua)  
    else  
        error("can not unserialize a " .. t .. " type.")  
    end
    lua = "return "..lua
    -- print(lua)
    local func = assert(loadstring(lua))()
    -- func=assert(loadstring("return "..lua))()
    -- print(func)
    if func == nil then  
        return nil  
    end  
    return func
end

-- 判断元素是否在表里
function Functions.belongsToTable(element, table)
  -- print("table",unpack(table))
  -- print("element",element)
	for k,v in pairs(table) do
		if element == v then
      -- print("fdslafjdklsajfdjsal",k,v)
			return true
		end 
	end
	return false
end
function Functions.GetHeroByName( heroName )
  for k,v in pairs(GameData.GameStatus.AllHeros) do
    if v.Name == heroName then
      return v
    end
  end
  return false
end
function Functions.AddFoodListener(target,parameters)
  target:setTouchEnabled(true)
  local stream_x = parameters.stream_x
  local stream_y = parameters.stream_y
  local stream_size = parameters.stream_size
  local function touch(event)
        if event.name == "began" then 
          target.parent.beginPoint_x = event.x
          target.parent.beginPoint_y = event.y
          -- 弹出出产苹果的原料等信息
          -- we need to write a new node
          target.p = display.newSprite("ui_background_9.png")
          -- node 下面画素材
          local recipe = Food[target.name].construct
          local recipeNumber = 0 
             for key, value in pairs(recipe) do 
                recipeNumber = recipeNumber + 1
                local src = Food[key].src
                local number = GameData.GameStatus.Food[key].number
                local food = display.newSprite(src)
                food:setPosition(ccp(100*recipeNumber,100))
                target.p:addChild(food)
                -- a ttf
                local numberTTF = ui.newTTFLabel({
                  text      = number.."/"..value,
                  font      = "Arial",
                  size      = numberSize,
                  x               = 0,
                  y               = 0,
                  color     = ccc3(255,0,0),
                  align     = ui.TEXT_ALIGN_CENTER,
                  --valign    = ui.TEXT_VALIGN_TOP,
                  --dimensions  = CCSize(400, 200),
                }):addTo(food,1)

             end 
          target.p:setAnchorPoint(ccp(0, 0))
          target:addChild(target.p)
          -- 根据苹果的位置设立弹窗的位置
          if target.posInScreeny > 0.5*display.height then 
             target.p:setPosition(ccp(-200,-300))
          else 
             target.p:setPosition(ccp(100,0))
          end
          -- end of popup 
          return true
----------------------- move ---------------------------------------
        elseif event.name == "moved" then 
          -- 计算移动量
          target.parent.delta_x = event.x - target.parent.beginPoint_x
          target.parent.delta_y = event.y - target.parent.beginPoint_y
          -- 计算苹果相对节点和屏幕的位置
          local target_current_posx = target.posx+target.parent.delta_x
          local target_current_posy = target.posy+target.parent.delta_y
          local target_posInScreenx = target.posInScreenx + target.parent.delta_x
          local target_posInScreeny = target.posInScreeny + target.parent.delta_y
          target:setPosition(ccp(target_current_posx,
                                target_current_posy))
          -- 根据苹果的位置调节弹窗的位置
          if target_posInScreeny > 0.5*display.height then 
             target.p:setPosition(ccp(-200,-300))
          else 
             target.p:setPosition(ccp(100,0))
          end
          -- 检查苹果与流水的碰撞
          collisionRegion = parameters.Rect
          local IsCollision = collisionRegion:containsPoint(ccp(target_current_posx,target_current_posy))
          -- 如果第一次碰撞
          if IsCollision and not target.parent.added then
             -- 如果没有苹果，在第一个流水中画苹果
             if target.parent.iNumberFood == 0 then 
                target.parent.added = true
                local sprite = display.newSprite(target.src):pos(stream_x,stream_y-0.25*78):addTo(target.parent,6)
                table.insert(target.parent.StreamTable,sprite)
                target.parent.iNumberFood = target.parent.iNumberFood + 1
             -- 如果有苹果  
             else 
                -- 如果流水线未满，画上苹果吧。。。
                if target.parent.iNumberFood < target.parent.iNumberStream then 
                   target.parent.added = true
                   local sprite = display.newSprite(target.src):pos(stream_x+(target.parent.iNumberFood+0.5)*stream_size,stream_y):addTo(target.parent,6)
                   -- 标记该苹果，苹果数+1
                   table.insert(target.parent.StreamTable,sprite)
                   target.parent.iNumberFood = target.parent.iNumberFood + 1
      
                else  
                -- 流水线满了，弹出“流水已满” 弹幕
                   -- 如果有弹幕，先删除之                  
                   if target.parent.stringAdded then 
                      if target.parent.string then     
                         target.parent.string:removeSelf()
                         target.parent.stringAdded = false
                      end
                   end     
                   -- 如果没有弹幕，标记之，点击结束后产生弹幕               
                      target.parent.shouldAdded = true                    
                end 
             end
          end
          -- 苹果在非碰撞区，而且苹果已经摆上了
          if not IsCollision and target.parent.added then
             -- we should delete the corresponding sprite,so need a table
             --table.insert(StreamTable,sprite)
             -- 删掉该苹果图像
             local iNumberTable = #target.parent.StreamTable
             target.parent.StreamTable[iNumberTable]:removeSelf()
             target.parent.added = false
             -- 苹果数-1
             target.parent.iNumberFood = target.parent.iNumberFood - 1
             table.remove(target.parent.StreamTable,iNumberTable)
          end
          -- 苹果在非碰撞区，不应该产生弹幕
          if not IsCollision then
             target.parent.shouldAdded = false
          end
  --------------------------------  end ----------------------------
        elseif event.name == "ended" then 
          print("cook = ",GameData.GameStatus.Farm[parameters.restaurant].cook)

          -- 点击结束时，若苹果还在，则把它存下来
          if target.parent.added == true then
             -- 计算材料
             local isResourceEnough = true 
             local rareResource = {}
             local recipe = Food[target.name].construct
             for key, value in pairs(recipe) do 
                 print(key,"  ",GameData.GameStatus.Food[key].number)
                 local number = GameData.GameStatus.Food[key].number - value
                 if number < 0 then 
                    table.insert(rareResource,{Food[key].src,number})
                    isResourceEnough = false 
                 end 

             end 
             --local src = -5
             -- 剩余材料，可生产，存下 
             if isResourceEnough then 
                -- calculate baoji and time saved by cook 
                local dt = 0 
                local double = false 
                -- 置初始的暴击概率为0
                local prob = 0 
                -- 置初始的熟练度为0
                local shuliandu = 0
                -- loop over chushi
                for key, value in pairs(GameData.GameStatus.Farm[parameters.restaurant].cook) do 
                    -- e.g. value = "yutujing"
                   -- shuliandu = shuliandu + value.shuliandu
                    local cook = require("app/data/Fighters/" .. value)
                    print("the type is :",cook.CookSkill.type)
                    if cook.CookSkill.type == "cd" then 
                       dt = dt + cook.CookSkill.time  
                    end 
                    if cook.CookSkill.type == "baoji" then 
                        for food, number in pairs(recipe) do
                            if food == cook.CookSkill.food[1] or food == cook.CookSkill.food[2] then 
                              print("the same food")
                               -- 如果满足食材条件,概率增加
                              prob = prob + cook.CookSkill.prob
                            end 
                        end 
                        -- local random = Functions.RandomBetweenLowAndUp(0,100)
                        -- if random < value.skill.prob then
                        --   print("baoji")
                        --   double = true 
                        -- end 
                    end 
                end
                -- print("shuliandu =",shuliandu)
                -- local dprob = Functions.calculateProb(shuliandu)
                -- print("dprob =",dprob)
                -- prob = prob + dprob
                print("prob=",prob)
                local random = Functions.RandomBetweenLowAndUp(0,100)
                if random < prob then
                  print("baoji")
                  double = true 
                end 
                -- sth to do here 
                -- 减少素材
                for key, value in pairs(recipe) do 
                    GameData.GameStatus.Food[key].number = GameData.GameStatus.Food[key].number - value
                end
                table.insert(GameData.GameStatus.Farm[parameters.restaurant].queuetime,Food[target.name].time - dt )
                GameData.GameStatus.Farm[parameters.restaurant].createtime = os.time()
                -- upload 
                -- 显示时间
                if target.parent.messagelabel then 
                   if not target.parent.waitinglist then
                      -- 没有排队的文字，就加一个
                      print("addwaiting")
                      local messageLabelParams = 
                      {
                        text = "Waiting...",
                        font = ui.DEFAULT_TTF_FONT,
                        size = 30,
                        align = ui.TEXT_ALIGN_CENTER,
                        color = ccc3(0, 0, 0),
                      }
                      target.parent.waitinglist = ui.newTTFLabel(messageLabelParams)
                      target.parent:addChild(target.parent.waitinglist)
                      target.parent.waitinglist:setPosition(stream_x+1.5*stream_size,stream_y+0.9*78)
                   end 
                else -- label 1 处理没有计时器的情形
                print("addtimer")
                local messageLabelParams = 
                {
                  text       = "2分",
                  font       = ui.DEFAULT_TTF_FONT,
                  size       = 30,
                  align      = ui.TEXT_ALIGN_CENTER,
                  color      = ccc3(0, 0, 0),
                }
    
                target.parent.messagelabel = ui.newTTFLabel(messageLabelParams)
                
                target.parent.messagelabel.minute = 0
                target.parent.messagelabel.second = Food[target.name].time - dt 
                target.parent:addChild(target.parent.messagelabel)
                target.parent.messagelabel:setPosition(stream_x,stream_y+0.9*78)
       
                -- 计时器函数     
               local function update(dt)
                  target.parent.messagelabel.second =target.parent.messagelabel.second - dt
                  if target.parent.messagelabel.second < 0 then
                     target.parent.messagelabel.second = target.parent.messagelabel.second + 60
                     target.parent.messagelabel.minute = target.parent.messagelabel.minute -1
                  end
                local string = ""
                if target.parent.messagelabel.minute ~= 0 then 
                   string = string..target.parent.messagelabel.minute.."分"
                end 
                local second = math.floor(target.parent.messagelabel.second)
                if second ~= 0 then 
                   string = string..second.."秒"
                end

      ------  **************** 处理某产品完成 (计时器的时间为0)
        if target.parent.messagelabel.minute == 0 and second == 0 then
           -- step 1,重绘
           --GameData.save()
           target.parent.StreamTable[1]:removeSelf()
           target.parent.iNumberFood = target.parent.iNumberFood - 1
           table.remove(target.parent.StreamTable,1)
           -- 产品数是守恒的，生产好的先放在门口
           local productname = GameData.GameStatus.Farm[parameters.restaurant].duilie[1].src
           local sprite = display.newSprite(productname)
           --GameData.save()
           --sprite:setPosition()
           print("sprite=",sprite)
           print("name = ",productname)
           print("double = ",double)
           target.parent[parameters.restaurant]:addChild(sprite,300)
           --GameData.save()
           table.insert(target.parent[parameters.restaurant].product,{src=sprite,name = target.name,isDouble = double})
           table.insert(GameData.GameStatus.Farm[parameters.restaurant].product,{name = target.name,isDouble = double})
           --print(table.concat(target.parent.bakery.product,"!"))
           -- 以上的处理完毕
           -- 处理数据部分，获得的食物存下,并且更改队列
           local number = #target.parent.StreamTable
           print("stream =",number)
           --GameData.save()
           for i = 1,number do 
             GameData.GameStatus.Farm[parameters.restaurant].duilie[i] = GameData.GameStatus.Farm[parameters.restaurant].duilie[i+1]
           end
           GameData.GameStatus.Farm[parameters.restaurant].duilie[number+1] = {src = "empty"}
            if GameData.GameStatus.Farm[parameters.restaurant].duilie[1].src ~= "empty" then 
                    print("name =",GameData.GameStatus.Farm[parameters.restaurant].duilie[1].name)
                    GameData.GameStatus.Farm[parameters.restaurant].createtime = GameData.GameStatus.Farm[parameters.restaurant].createtime + GameData.GameStatus.Farm[parameters.restaurant].queuetime[1]
                    -- delete data in queue
                    table.remove(GameData.GameStatus.Farm[parameters.restaurant].queuetime,1)
                    print("remove queuetime")
            else
                -- 处理队列为空
                    GameData.GameStatus.Farm[parameters.restaurant].createtime = nil
                    if GameData.GameStatus.Farm[parameters.restaurant].queuetime[1] then 
                       table.remove(GameData.GameStatus.Farm[parameters.restaurant].queuetime,1)
                       print("remove queuetime")
                    end 
            end
           GameData.save()
           --- 处理流水相关的
           -- 流水上没有等的
           if number <= 1 then
              -- 删掉waiting label 
              if target.parent.waitinglist then 
                target.parent.waitinglist:removeSelf()
                target.parent.waitinglist = nil
                print(target.parent.waitinglist)
              end
           end

           if number >= 1 then 
             -- 重置计时器的时间,we need the time
             -- this is not correct 
             target.parent.messagelabel.second = GameData.GameStatus.Farm[parameters.restaurant].queuetime[1] 
             target.parent.StreamTable[1]:setPosition(stream_x,stream_y-0.25*78)
             for i = 2,number do 
               target.parent.StreamTable[i]:setPosition(stream_x+(i-0.5)*stream_size,stream_y)
             end
           else 
             -- 没有任何食物,删掉计时器
             print("nofood")

             target.parent.messagelabel:unscheduleUpdate()
             target.parent.messagelabel:removeSelf()
             target.parent.messagelabel = nil
             print(target.parent.messagelabel)
           end
           
        end
        -- ***********************   end of 处理某产品完成

                if target.parent.messagelabel then 
                  target.parent.messagelabel:setString(string)
                end
               

        end
        ---------------------   end of update 计时器函数结束--------------------------
                target.parent.messagelabel:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, update)
                target.parent.messagelabel:scheduleUpdate()
               end  -- end of else label 1, 
                --- 更新数据，队列数据中加入该食品
                GameData.GameStatus.Farm[parameters.restaurant].duilie[target.parent.iNumberFood].src = target.src
                GameData.GameStatus.Farm[parameters.restaurant].duilie[target.parent.iNumberFood].name = target.name
                GameData.GameStatus.Farm[parameters.restaurant].duilie[target.parent.iNumberFood].isDouble = double
                GameData.save()
             
             else
                -- 材料不足的处理
               --删掉苹果图
                local iNumberTable = #target.parent.StreamTable
                target.parent.StreamTable[iNumberTable]:removeSelf()
                target.parent.added = false
                -- 苹果数-1
                target.parent.iNumberFood = target.parent.iNumberFood - 1
                table.remove(target.parent.StreamTable,iNumberTable)
                --弹窗提示资源不够
                --local string = tostring(-rareResource[1][2])
                CCDirector:sharedDirector():getRunningScene():addChild(NotEnoughResource.new(
               {
                -- 资源名和数量
                src = rareResource,
                --number = string
               }))
             end
          end
          -- 如果应该产生弹幕，那便产生吧
          if target.parent.shouldAdded == true then
             target.parent.stringAdded = true
             target.parent.string = UI_FlyString.new({message = "流水线已满!",parent = target.parent})            
             target.parent.string:setPosition(0,0)
             target.parent:addChild(target.parent.string,200)
             target.parent.shouldAdded = false
          end
          -- 重置苹果图标，删掉弹窗
          target.p:removeSelf()
          target:setPosition(ccp(target.posx,target.posy))
          target.parent.added = false
   ----------------------------  end of touch end -----------------------       
        elseif event.name == "cancelled" then 
        end
      end   ----- end of function touch 
      target:addNodeEventListener(cc.NODE_TOUCH_EVENT,touch)
    
end

function Functions.isInsidePolygon(x,y,points)
	-- 射线法判断点（ｘ，ｙ）是否在多边形内
	-- 初始交点数设为0
	local iNumberofIntersects = 0
	local iNumberofPoints = #points.x

  for i = 1, iNumberofPoints do 
  	local j = i+1
  	if j >iNumberofPoints then
  		j = j-iNumberofPoints
  	end
	local lambda = (y-points.y[i])/(points.y[j]-points.y[i])
	--print(lambda)
	if lambda < 1 and lambda >0 then
		local pointOnLine_x = points.x[i]+(points.x[j]-points.x[i])*lambda
		if x < pointOnLine_x then 
		   iNumberofIntersects = iNumberofIntersects + 1
	    end

	end 
  end -- end of for 
    --print(iNumberofIntersects)
    if iNumberofIntersects % 2 == 0 
    then return false 
    else return true
    end 

end

function Functions.transformPoint( x, y, direction )
	local xOut, yOut, zOut
	if direction == "direct" then
	            xOut = 0.9346*x-0.1530*y+33.2635
	            yOut = 0.8512*y+17.0924
	            zOut = -0.0003*y+1
	            xOut = xOut/zOut
	            yOut = yOut/zOut
	elseif direction == "inverse" then
	            xOut = 1.076423632830687*x+0.179813943200664*y-38.879089910220530
	            yOut = 1.174856*y-20.0811
	            zOut = 0.000352*y+1
	            xOut = xOut/zOut
	            yOut = yOut/zOut 
	else
	            return "transform_Wrong"
	end
	return xOut,yOut
end
return Functions