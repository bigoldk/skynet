--
-- Author: Wu Jian
-- Date: 2014-08-05 21:47:56
--
local NetworkApi = {}
local GameState = require(cc.PACKAGE_NAME .. ".api.GameState")
local UI_WrongServer = import("..ui.UI_WrongServer")
local Functions = import("..utils.Functions")
function NetworkApi.uploadFile(callback, url, datas)
    network.uploadFile(callback, url, datas)
end
function NetworkApi.createHTTPRequest(target, url, callback)
	local function networkcallback( event )
		if tolua.isnull(target) then
            if target == "shadoumeiyou" then
            else
                print("REQUEST COMPLETED, BUT SCENE HAS QUIT")
                return
            end
        end
        callback(event)
	end
	local method = "GET"
	local request = network.createHTTPRequest(networkcallback, url, method)
	print("REQUEST START")
    request:start()
end
function NetworkApi.createHTTPRequestByPost(target, url, callback, postvalues)
	local function networkcallback( event )
		if tolua.isnull(target) then
            if target == "shadoumeiyou" then 
            else
                print("REQUEST COMPLETED, BUT SCENE HAS QUIT")
                -- added by Yi Feng
                -- return
            end
        end
        callback(event, true)
	end
	local method = "POST"
	local request = network.createHTTPRequest(networkcallback, url, method)
	for i in pairs(postvalues) do
        print("add a piece of postvalue")
		request:addPOSTValue(i, postvalues[i])
	end
	print("REQUEST START")
    request:start()
end

function NetworkApi.onResponse_login( event, dumpResponse )
	print("enter game ..., we need to check md5")
	local request = event.request
	-- print("REQUEST - event.name =", event.name)
    if event.name == "completed" then
        if request:getResponseStatusCode() ~= 200 then
        	print("ResponseStatusCode = ", request:getResponseStatusCode())
        	return
        else
            -- if we have waiting label, then we should delete it
            if NetworkApi.waitingLabel then 
               NetworkApi.waitingLabel:removeSelf()
               NetworkApi.waitingLabel = nil
            end

            if NetworkApi.wrongNode then 
               NetworkApi.wrongNode:removeSelf()
               NetworkApi.wrongNode = nil
            end
            print("REQUEST - DataLength", request:getResponseDataLength())
            if dumpResponse then
            	
            end
            local responsestring = request:getResponseString()

            print("REQUEST - response: \n", responsestring)
           
            local b = assert(loadstring("return "..responsestring))()
            --responsestring = b()
            print("the type is of return value",type(b))
            print("isMd5Correct =",b.isMd5Correct)
            if b.isMd5Correct then 
            	-- do nothing
                print("md5 is the same !!! continue game ...")
            else 
            	-- part C,  deal  with wrong md5
            	print("md5 is wrong... we need data from server")
            	GameData.GameStatus = b.GameData
            	GameState.encode_(b)
            	print("md5 send to server is",GameState.saveContentMd5)
            	-- then we should send this md5 to server,if received,then save it as local file
            	--local url = "118.192.77.18:8001"
                GameData.postvalues = {request = "postmd5",username = "YiFeng", password = "xyzgkch",md5 = GameState.saveContentMd5}
                --NetworkApi.createHTTPRequestByPost(self, url, handler(self, self.onResponse),postvalues)
                GameData.func = NetworkApi.onResponse_postmd5
                --local target = CCDirector:sharedDirector():getRunningScene()
                --print(target)
                --print(tolua.isnull(target))
                NetworkApi.createHTTPRequestByPost(self, GameData.url, GameData.func, GameData.postvalues)
            end
            -- local responsetable = json.decode(responsestring)
            -- print(type(responsetable))
            -- GameStatus.CurrentDrop = clone(responsetable)

            --self.ReadyToReplaceScene = true
            
        end
    else
        printf("REQUEST - getErrorCode() = %d, getErrorMessage() = %s", request:getErrorCode(), request:getErrorMessage())
    	-- B part,deal with wrong web
        -- if we have waiting label, then we should delete it 
        if request:getErrorCode() ~= 0 then 
           if NetworkApi.waitingLabel then 
              NetworkApi.waitingLabel:removeSelf()
              NetworkApi.waitingLabel = nil
           end

        end

    	if request:getErrorCode() ~= 0 then 
            if not NetworkApi.wrongNode then 
               print("I should add a node here")
               NetworkApi.wrongNode = NetworkApi.UI_WrongServer()
               local target = CCDirector:sharedDirector():getRunningScene()
               target:addChild(NetworkApi.wrongNode)
            end
        end

    	return
    end
    --self.ReadyToReplaceScene = true
end
function NetworkApi.GetTable()
    local url = "118.192.77.18:8001"
    local postvalues = 
        {
          request = "gettable",
          username = GameData.Username,
        }
    NetworkApi.createHTTPRequestByPost("shadoumeiyou", url, NetworkApi.testgettable ,postvalues)
end
function NetworkApi.DeleteTable()
    local url = "118.192.77.18:8001"
    local postvalues = 
        {
          request = "deletetable",
          username = GameData.Username,
        }
    NetworkApi.createHTTPRequestByPost("shadoumeiyou", url, NetworkApi.testnilfunction ,postvalues)
end
function NetworkApi.SaveTable()
    local url = "118.192.77.18:8001"
    local postvalues = 
        {
          request = "savetable",
          username = GameData.Username,
          data = Functions.serialize({GameData.GameStatus})
        }
    NetworkApi.createHTTPRequestByPost("shadoumeiyou", url, NetworkApi.testnilfunction ,postvalues)
end
function NetworkApi.testgettable(event, dumpResponse)
    local request = event.request
    if event.name == "completed" then
        local string = request:getResponseString()
        if string ~= "user not found" then
            local table = Functions.unserialize(string.urldecode(string))[1]
            print(table.TeamMembers[1])
            GameData.GameStatus = table
            print("welcome old user")
        else
            print("welcome new user")
        end
        app:enterScene("TownScene")
    end
end
function NetworkApi.testnilfunction(event, dumpResponse)
    local request = event.request
    if event.name == "completed" then
          print("requestcompleted")
    end
end
function NetworkApi.onResponse_postValues( event, dumpResponse )
	print("enter game ..., we need to check md5")
	local request = event.request
	-- print("REQUEST - event.name =", event.name)
    if event.name == "completed" then
        if request:getResponseStatusCode() ~= 200 then
        	print("ResponseStatusCode = ", request:getResponseStatusCode())
        	return
        else
            -- if we have waiting label, then we should delete it
            if NetworkApi.waitingLabel then 
               NetworkApi.waitingLabel:removeSelf()
               NetworkApi.waitingLabel = nil
            end

            if NetworkApi.wrongNode then 
               NetworkApi.wrongNode:removeSelf()
               NetworkApi.wrongNode = nil
            end

            print("REQUEST - DataLength", request:getResponseDataLength())
            if dumpResponse then
            	
            end
            local responsestring = request:getResponseString()

            print("REQUEST - response: \n", responsestring)
           
            local b = assert(loadstring("return "..responsestring))()
            --responsestring = b()
            print("the type is of return value",type(b))
            print("isMd5Correct =",b.isMd5Correct)
            if b.isMd5Correct then 
            	-- we need to 
                local saveFile = CCFileUtils:sharedFileUtils():fullPathForFilename("GameStatus.txt")

            	os.remove (saveFile)
                local tempFile = CCFileUtils:sharedFileUtils():fullPathForFilename("GameStatusTemp.txt")
                os.rename (tempFile,saveFile)
                print("delete,rename temp file!!! continue game ...")
            else 
            	-- part C,  deal  with wrong md5
            	print("md5 is wrong... we need data from server")
            	GameData.GameStatus = b.GameData
            	GameState.encode_(b.GameData)
            	print("md5 send to server is",GameState.saveContentMd5)
            	-- then we should send this md5 to server,if received,then save it as local file
            	--local url = "118.192.77.18:8001"
                GameData.postvalues = {request = "postmd5",username = "YiFeng", password = "xyzgkch",md5 = GameState.saveContentMd5}
                GameData.func = NetworkApi.onResponse_postmd5
                --NetworkApi.createHTTPRequestByPost(self, url, handler(self, self.onResponse),postvalues)
                --local target = CCDirector:sharedDirector():getRunningScene()
                --print(target)
                --print(tolua.isnull(target))
                NetworkApi.createHTTPRequestByPost(self, GameData.url, GameData.func,GameData.postvalues)
            end
            -- local responsetable = json.decode(responsestring)
            -- print(type(responsetable))
            -- GameStatus.CurrentDrop = clone(responsetable)

            --self.ReadyToReplaceScene = true
            
        end
    else
        printf("REQUEST - getErrorCode() = %d, getErrorMessage() = %s", request:getErrorCode(), request:getErrorMessage())
    	-- B part,deal with wrong web
        -- if we have waiting label, then we should delete it 
        if request:getErrorCode() ~= 0 then 
           if NetworkApi.waitingLabel then 
              NetworkApi.waitingLabel:removeSelf()
              NetworkApi.waitingLabel = nil
           end

        end

        if request:getErrorCode() ~= 0 then 
            if not NetworkApi.wrongNode then 
               print("I should add a node here")
               NetworkApi.wrongNode = NetworkApi.UI_WrongServer()
               local target = CCDirector:sharedDirector():getRunningScene()
               target:addChild(NetworkApi.wrongNode)
            end
        end
    	return
    end
    --self.ReadyToReplaceScene = true
end

function NetworkApi.onResponse_postmd5( event, dumpResponse )
	local request = event.request
	-- print("REQUEST - event.name =", event.name)
    if event.name == "completed" then
        if request:getResponseStatusCode() ~= 200 then
        	print("ResponseStatusCode = ", request:getResponseStatusCode())
        	return
        else
            -- if we have waiting label, then we should delete it
            if NetworkApi.waitingLabel then 
               NetworkApi.waitingLabel:removeSelf()
               NetworkApi.waitingLabel = nil
            end

            if NetworkApi.wrongNode then 
               NetworkApi.wrongNode:removeSelf()
               NetworkApi.wrongNode = nil
            end

            print("REQUEST - DataLength", request:getResponseDataLength())
            if dumpResponse then
            	
            end
            local responsestring = request:getResponseString()

            print("REQUEST - response: \n", responsestring)
           
            -- server has received the md5, then save data to local 
            GameData.save()  
            local tempFile = CCFileUtils:sharedFileUtils():fullPathForFilename("GameStatusTemp.txt")
            os.remove(tempFile)                
        end
    else
        print("error in post md5")
        printf("REQUEST - getErrorCode() = %d, getErrorMessage() = %s", request:getErrorCode(), request:getErrorMessage())
    	-- B part
        -- if we have waiting label, then we should delete it 
        if request:getErrorCode() ~= 0 then 
           if NetworkApi.waitingLabel then 
              NetworkApi.waitingLabel:removeSelf()
              NetworkApi.waitingLabel = nil
           end

        end

        if request:getErrorCode() ~= 0 then 
            if not NetworkApi.wrongNode then 
               print("I should add a node here")
               NetworkApi.wrongNode = NetworkApi.UI_WrongServer()
               local target = CCDirector:sharedDirector():getRunningScene()
               target:addChild(NetworkApi.wrongNode)
            end
        end
    	return
    end
    --self.ReadyToReplaceScene = true
end

-- 重试button
function NetworkApi.UI_WrongServer()
    local node = display.newNode()
    -- return a node, and we need a layer to swallow clicks 
    local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:setTouchSwallowEnabled(true)
    node:addChild(layer)

    local exitbutton = ui.newImageMenuItem({
        image       = "pause.jpg",
        imageSelected = "pause.jpg",
        --imageDisabled = image,
        x               = 0,
        y               = 0,
        listener        = function() 
            print("I am test this button")
            -- retry
            NetworkApi.createHTTPRequestByPost(self, GameData.url, GameData.func,GameData.postvalues)
            -- while retry, we should popup another node
            
            node:removeSelf()
            NetworkApi.wrongNode = nil
            print("node=",node)
            NetworkApi.waitingLabel = NetworkApi.UI_Waiting()
            local target = CCDirector:sharedDirector():getRunningScene()
            target:addChild(NetworkApi.waitingLabel)
         end,
    })
    local size = CCDirector:sharedDirector():getWinSize()
    menu = ui.newMenu({exitbutton}):pos(size.width/2,size.height/2):addTo(node, 5)
    return node
end

function NetworkApi.UI_Waiting()
    local node = display.newNode()
    local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:setTouchSwallowEnabled(true)
    node:addChild(layer)

    local size = CCDirector:sharedDirector():getWinSize()
    local waitingLabel = ui.newTTFLabel({
        text            = "Waiting...",
        font            = "Arial",
        size            = 30,
        x               = 0,
        y               = -20,
        color           = ccc3(123,123,234),
        align           = ui.TEXT_ALIGN_LEFT,
        --valign        = ui.TEXT_VALIGN_TOP,
        --dimensions    = CCSize(400, 200),
    }):pos(size.width/2,size.height/2):addTo(node, 5)
    return node
end

return NetworkApi