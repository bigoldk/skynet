local skynet = require "skynet"
local class = require "class"
local FighterInBattle = require "FighterInBattle"
local FightSceneNew = require "FightSceneNew"
local GameStatus = require "Gamestatus"
local Functions = require "Functions"
local Tables = require "Tables"
local arena = class("arena")

-- print("flag before fightscenearena")
-- local FightSceneArena = FightSceneNew.new()

local function dump(obj)
    local getIndent, quoteStr, wrapKey, wrapVal, dumpObj
    getIndent = function(level)
        return string.rep("\t", level)
    end
    quoteStr = function(str)
        return '"' .. string.gsub(str, '"', '\\"') .. '"'
    end
    wrapKey = function(val)
        if type(val) == "number" then
            return "[" .. val .. "]"
        elseif type(val) == "string" then
            return "[" .. quoteStr(val) .. "]"
        else
            return "[" .. tostring(val) .. "]"
        end
    end
    wrapVal = function(val, level)
        if type(val) == "table" then
            return dumpObj(val, level)
        elseif type(val) == "number" then
            return val
        elseif type(val) == "string" then
            return quoteStr(val)
        else
            return tostring(val)
        end
    end
    dumpObj = function(obj, level)
        if type(obj) ~= "table" then
            return wrapVal(obj)
        end
        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"
        for k, v in pairs(obj) do
            tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
        end
        tokens[#tokens + 1] = getIndent(level - 1) .. "}"
        return table.concat(tokens, "\n")
    end
    return dumpObj(obj, 0)
end

-- print("flag after fightsceneArena")



function arena:ctor(attackerHeroList, defencerHeroList, attackerCaptainList, defencerCaptainList)
    local res = FightSceneNew.new(attackerHeroList, defencerHeroList, attackerCaptainList, defencerCaptainList)
    self.process = res.process    
    return res

end




return arena