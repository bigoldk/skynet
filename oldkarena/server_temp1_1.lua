
local skynet = require "skynet"
local socket = require "socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
local table = table
local string = string
local mysql = require "mysql"
-- local fightlogic = require "fightlogic.logic"
local arena = require "arena"
local redis = require "redis"
local mode = ... 

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


local function response(id, ...)
	local ok, err = httpd.write_response(sockethelper.writefunc(id), ...)
	if not ok then
		-- if err == sockethelper.socket_error , that means socket closed.
		skynet.error(string.format("fd = %d, %s", id, err))		
	end
end

--print(mode)
--print(db)

if mode == "agent" then
	skynet.start(function(db)
		skynet.dispatch("lua", function (_,_,id)
			
			socket.start(id)
			-- limit request body size to 8192 (you can pass nil to unlimit)
			local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id),8192)
			print("code",code,"url",url,"method",method,"header",header,"body:",body)
			-------------------------------------------------
			--text analysis

			local temp = {}
			local fla = string.find(body, "=")
			local en = string.find(body,"&")
			local star=1
			while fla do
				if en~=-1 then
					local test1=string.sub(body,star,fla-1)
					local test2=string.sub(body,fla+1,en-1)
					temp[test1] = test2
				else
					local test1=string.sub(body,star,fla-1)
					local test2=string.sub(body,fla+1,en)
					temp[test1] = test2
					break
				end

				star = en+1
				fla = string.find(body,"=",star)
				en = string.find(body,"&",star)	or -1
			end

			for i in pairs(temp) do
				print(i,temp[i])
			end

			-------------------------------------------------
			-- db = mysql.connect{	
			-- 	host="127.0.0.1",
			-- 	port=3306,
			-- 	database="logintest",
			-- 	user="root",
			-- 	password="123",
			-- 	max_packet_size = 1024 * 1024
			-- }
			-- if db then
			-- 	print("mysql server connected")
			-- else
			-- 	print("fuck, it cannot connect to the mysql server")
			-- 	response(id,code,"server error,please try later")
			-- end

			if temp["request"] == "savetable" then
				local res = db:query("select * from cats where username=\'"..temp["username"].."\'")
				-- print("flag")
				if not(unpack(res)) then
					print("1")
					res = db:query("insert into cats (username,data)values(\'"..temp["username"].."\', \'"..temp["data"].."\')")
					res = db:query("select * from cats")
					print(dump(res))
					response(id,code,"user "..temp["username"].." inserted")
				else
					print("2")
					res = db:query("update cats set data =\'"..temp["data"].."\' where username=\'"..temp["username"].."\'")
					res = db:query("select * from cats")
					print(dump(res))
					response(id,code,"user "..temp["username"].." updated")

				end
			end

			if temp["request"] == "gettable" then
				local res = db:query("select * from cats where username=\'"..temp["username"].."\'")
				if not(unpack(res)) then
					print("user "..temp["username"].." not found")
					response(id,code,"user not found")
				else
					res = db:query("select data from cats where username=\'"..temp["username"].."\'")
					print("send data of user "..temp["username"])
					response(id,code,res[1]["data"])
				end

			end

			if temp["request"] == "deletetable" then

				local res = db:query("delete from cats where username =\'"..temp["username"].."\'")
			end

			if temp["request"] == "arena" then
				print("arena flag")
				local conf = {
					host = "127.0.0.1",
					port = 6379,
					db = 4,
				}
				local db = redis.connect(conf)
				local attacker = temp["username"]
				local defencer = temp["opponent"]
				local atkteam = {}
				local defteam = {}
				for i = 1,5 do
					local stratk = temp["attacker"..i.."pos"]
					local strdef = temp["defencer"..i.."pos"]
					local posatk = {tonumber(string.sub(stratk,1,1)),tonumber(string.sub(stratk,2,2))}
					local posdef = {tonumber(string.sub(strdef,1,1)),tonumber(string.sub(strdef,2,2))}
					atkteam[i] = {fighterName = temp["attacker"..i],initPos = posatk}
					defteam[i] = {fighterName = temp["defencer"..i],initPos = posdef}
				end
				-- for i = 1,5 do
				-- 	print("atkteam,",atkteam[i]["fighterName"],atkteam[i]["initPos"][1],atkteam[i]["initPos"][2])
				-- 	print("defteam,",defteam[i]["fighterName"])
				-- end
				local attackerHeroList = {}
				local defencerHeroList = {}

				for i = 1,5 do
					local tem = {}
					local Levell = 1
					local Starr = 1
					local res = db:exists(attacker..":"..atkteam[i].fighterName)
					if res then
						Levell = tonumber(db:hget(attacker..":"..atkteam[i].fighterName,"Level"))
						Starr = tonumber(db:hget(attacker..":"..atkteam[i].fighterName,"Star"))
					else
						db:hset(attacker..":"..atkteam[i].fighterName,"Level",1)
						db:hset(attacker..":"..atkteam[i].fighterName,"Star",1)
					end

					tem["Fighter"] = {Name = atkteam[i].fighterName,Level = Levell, Star = Starr,Gift = "None",Item = {}}
					tem["Index"] = i
					tem["onStage"] = 0
					tem["initPos"] = atkteam[i].initPos
					print("attackers here,",dump(tem["Fighter"]))
					attackerHeroList[i] = tem
				end
				for i = 1,5 do
					print("hey you",dump(attackerHeroList[i]))
				end

				for i = 1,5 do
					local tem = {}
					local Levell = 1
					local Starr = 1
					local res = db:exists(defencer..":"..defteam[i].fighterName)
					if res then
						Levell = tonumber(db:hget(defencer..":"..defteam[i].fighterName,"Level"))
						Starr = tonumber(db:hget(defencer..":"..defteam[i].fighterName,"Star"))
					else
						db:hset(defencer..":"..defteam[i].fighterName,"Level",1)
						db:hset(defencer..":"..defteam[i].fighterName,"Star",1)
					end

					tem["Fighter"] = {Name = defteam[i].fighterName,Level = Levell, Star = Starr,Gift = "None",Item = {}}
					tem["Index"] = i
					tem["onStage"] = 0
					tem["initPos"] = defteam[i].initPos
					print("defencers here,",dump(tem["Fighter"]))
					defencerHeroList[i] = tem
				end

				for i = 1,5 do
					print("hey defencers",dump(defencerHeroList[i]))
				end
				local attackerCaptainList = {}
				local defencerCaptainList = {}

				local res = arena.new(defencerHeroList, attackerHeroList, attackerCaptainList, defencerCaptainList)
				print("hey you i got here")


				response(id, code, res.process)
			end

			if temp["request"] == "register" then
				
				local res = db:query("select * from cats where username=\'"..temp["username"].."\'")
				if not(unpack(res)) then
					res = db:query("select * from cats")
					print(dump(res))
					print(temp["username"].." inserted")
					response(id,code,"register success!")
				else
					print(temp["username"].." is already used")
					response(id,code,"username "..temp["username"].." is already used,please change one\n")
				end
				
				-- print(unpack(res),res)
			end


			if temp["request"]=="login" then
				local res = db:query("select password,md5,GameData from cats where username=\'"..temp["username"].."\'")
				print(res[1]["password"],res[1]["md5"],res[1]["GameData"])
				if not(unpack(res)) then
					print("user "..temp["username"].." not found")
					response(id,code,"user "..temp["username"].." not found不给力啊老湿")
				else
					-- if res[1]["password"]==temp["password"] then
					-- 	print("password correct,login success!你好啊小盆友")
					-- 	response(id,code,"login success!你好啊小盆友")
					if res[1]["password"]==temp["password"] then
						if res[1]["md5"]==temp["md5"] then
							response(id,code,"{isMd5Correct=true}")
						else
							response(id,code,"{isMd5Correct=false,GameData="..res[1]["GameData"].."}")
						end
						-- response(id,code,"login success!你好啊小盆友")
					else
						print("password not match,login denied")
						response(id,code,"password not match,login denied!不给力啊老湿")
					end
				end
			end

			if temp["request"]=="update" then
				local res = db:query("select md5 from cats where username=\'"..temp["username"].."\'")
				if res[1]["md5"]==temp["md5old"] then
					res = db:query("update cats set item=\'"..temp["item"].."\' where username=\'"..temp["username"].."\'")
					res = db:query("update cats set md5=\'"..temp["md5new"].."\' where username=\'"..temp["username"].."\'")
					response(id,code,"update completed")
				else
					response(id,code,"md5 not match,update failed")					
				end
			end

			if temp["request"]=="postvalues" then
				local res = db:query("select md5,data from cats where username=\'"..temp["username"].."\'")
				if res[1]["md5"]==temp["md5old"] then
					res = db:query("update cats set data=\'"..temp["data"].."\' where username=\'"..temp["username"].."\'")
					res = db:query("update cats set md5=\'"..temp["md5new"].."\' where username=\'"..temp["username"].."\'")
					response(id,code,"{isMd5Correct=true}")
				else

					response(id,code,"{isMd5Correct=false,GameData=\'"..res[1]["data"])					
				end
			end

			if temp["request"]=="postmd5" then
				local res = db:query("select md5 from cats where username=\'"..temp["username"].."\'")
				if res[1]["md5"]==temp["md5"] then
					response(id,code,"md5s match")
				else
					res = db:query("update cats set md5=\'"..temp["md5"].."\' where username=\'"..temp["username"].."\'")
					print("flag")
					response(id,code,"{isMd5Correct=false}")					
				end
			end
			
			-- db:disconnect()
			socket.close(id)
		end)
	end)

else
	
	skynet.start(function()


		local agent = {}
		-- for i= 1, 1 do
			agent[1] = skynet.newservice(SERVICE_NAME, "agent")
		-- end
		local balance = 1
		local id = socket.listen("0.0.0.0", 8001)
		socket.start(id , function(id, addr)
			print(addr,agent[balance])
			skynet.error(string.format("%s connected, pass it to agent :%08x", addr, agent[balance]))
			skynet.send(agent[balance], "lua", id)
			balance = balance + 1
			if balance > #agent then
				balance = 1
			end
		end)
	end)

end
