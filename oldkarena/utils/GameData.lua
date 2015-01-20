-- By Yi Feng
-- GameData 用来管理游戏需要存储的数据,数据都在GameStatus里

local GameData = {GameStatus={}}
local GameState = require(cc.PACKAGE_NAME .. ".api.GameState")
local gameStatus = import("..utils.GameStatus")
local Functions = import("..utils.Functions")
local NetworkApi = import("..utils.NetworkApi")

-- init 函数用来初始化游戏需要存储的数据
function GameData:init()

    -- 具体化GameState的init函数，数据存在"GameStatus.txt"中
	GameState.init(function(param)
        local returnValue=nil
        if param.errorCode then
            CCLuaLog("error")
        else
            -- crypto
            if param.name=="save" then
                local str=json.encode(param.values)
                -- 加密
                --str=crypto.encryptXXTEA(str, "abcde")
                returnValue={data=str}
            elseif param.name=="load" then
                -- 解密
                --local str=crypto.decryptXXTEA(param.values.data, "abcde")
                if param.values then 
                    -- if not nil 
                   local str = param.values.data
                   returnValue=json.decode(str)
                else 
                   returnValue=nil
                end
            end
            -- returnValue=param.values
        end
        return returnValue
    end, "GameStatus.txt","GameStatusTemp.txt","1234")
    -- 如果第一次进入游戏，还没有数据文件，那么用GameStatus创建一个，然后存下来
    -- if not io.exists(GameState.getGameStatePath()) then	
		GameData.GameStatus.PlayerName = gameStatus.PlayerName
		GameData.GameStatus.CurrentEnergy = gameStatus.CurrentEnergy
		GameData.GameStatus.TotalEnergy = gameStatus.TotalEnergy
		GameData.GameStatus.AllHeros = gameStatus.AllHeros
		GameData.GameStatus.MissionStars = gameStatus.MissionStars
		GameData.GameStatus.MissionRemainTimes = gameStatus.MissionRemainTimes
        GameData.GameStatus.TeamMembers = gameStatus.TeamMembers
        GameData.GameStatus.TeamCaptains = gameStatus.TeamCaptains
        GameData.GameStatus._music_on = gameStatus._music_on
        GameData.GameStatus.FarmCrop = gameStatus.FarmCrop
        GameData.GameStatus.Farm = gameStatus.Farm
        GameData.GameStatus.Food = gameStatus.Food
        GameData.GameStatus.FightItem = gameStatus.FightItem

        --GameData.GameStatus._sound_on = gameStatus._sound_on
        -- save
		-- GameState.save(GameData.GameStatus)
        --GameData.GameStatus = GameState.load()
        -- GameData.loadContentmd5 = "6d340f6930deb24d7d5df918052efc70"
        --GameData.saveContentmd5 = GameState.saveContentMd5
	-- else
		-- 之后从数据文件中读取游戏数据
		-- GameData.GameStatus = GameState.load()
        -- GameData.loadContentmd5 = GameState.loadContentMd5
        --GameData.saveContentmd5 = GameState.saveContentMd5
	-- end
    
end

-- 即时存档
function GameData:save()
    -- GameState.save(GameData.GameStatus)
    NetworkApi.SaveTable()
end

function GameData:saveTemp()
   GameState.saveTemp(GameData.GameStatus)
   GameData.saveTempContentmd5 = GameState.saveContentMd5
end

function GameData:load()
   print("load data ...")
   GameData.GameStatus = GameState.load()
   GameData.loadContentmd5 = GameState.loadContentMd5
end

return GameData