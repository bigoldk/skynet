-- login with md5 detect 2014.10.27

local skynet = require "skynet"
local redis = require "redis"
local socket = require "socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
local table = table
local string = string
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


local function _encode(str)
    return string.format("%%%02X",string.byte(str))
end

function emailEncode(str)
    return string.gsub(str,"([^%w_@.])",_encode)
end

local function _decode(str)
    return string.char(tonumber(str,16))
end

function emailDecode(str)
    return string.gsub(str,"%%(%w%w)",_decode)
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
		skynet.dispatch("lua", function (_,_,id,addr)

			print("skynet.self()",skynet.self())
			-- print("skynet.harbor()",skynet.harbor())
			

			if string.sub(addr,-1,-1) == "\x00" then
				print(string.sub(addr,-1,-1))
				print("that null exists!")
				print(string.len(addr))
				addr = string.sub(addr,1,-2)
			else
				print("that null does not exist")
				print(string.len(addr))
			end
			print("addrr",string.len(addr))

			socket.start(id)
			-- limit request body size to 8192 (you can pass nil to unlimit)
			local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), 8192)
			print("code",code)
			print("url",url)
			print("method",method)
			print("header",unpack(header))
			print("body:",body)
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
			local conf = {
				host = "127.0.0.1",
				port = 6379,
				db = 0
			}

			local db = redis.connect(conf)
			if db then
				print("redis connection success")
			else
				print("redis connection failed")
				response(id,code,"server error,please try later")
			end

			if temp["request"] == "register" then
				local res = db:exists("users:"..temp["username"])
				if res  then
					print("res",res)
					response(id,code,"username "..temp["username"].."exists already,please change your username")
					
				else
					local uid = db:incr("account:count")
					db:hmset("users:"..temp["username"],"password",temp["password"],"md5","6d340f6930deb24d7d5df918052efc70","account",temp["account"],"level","1","experience","0","money","0","tili","10","diamond","25","prestige","0","friends","0","LastLoginAddr",addr,"RegisterTime",os.time(),"LastLoginTime",os.time(),"uid",uid)
					local acccount = db:hget("users:"..temp["username"],"account")
					print("register success!!")
					response(id,code,"register success!!!")
				end
			end
			-- print("flag")

			if temp["request"] == "login" then
				local res = db:exists("users:"..temp["username"])
				if res then
					local pw = db:hget("users:"..temp["username"],"password")
					if pw == temp["password"] then
						print("user "..temp["username"].." login success")
						response(id,code,"login success")
						db:hset("users:"..temp["username"],"LastLoginAddr",addr)
						db:hset("users:"..temp["username"],"LastLoginTime",os.time())
						print(addr)
					else
						print("user "..temp["username"].." login failed,password not match")
						response(id,code,"login failed, password not match")
					end
				else
					response(id,code,"username not found, login failed")
				end
			end

			if temp["request"] =="update" then
				local res = db:exists("users:"..temp["username"])
			end



			
			socket.close(id)
		end)
	end)

else
	
	skynet.start(function()


		local agent = {}
		for i= 1, 20 do
			agent[i] = skynet.newservice(SERVICE_NAME, "agent")
		end
		local balance = 1
		local id = socket.listen("127.0.0.1", 8001)
		socket.start(id , function(id, addr)

			skynet.error(string.format("%s connected, pass it to agent :%08x", addr, agent[balance]))
			skynet.send(agent[balance], "lua", id, addr)
			balance = balance + 1
			if balance > #agent then
				balance = 1
			end
		end)
	end)

end
