local skynet = require "skynet"
local socket = require "socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
local table = table
local string = string
local mysql = require "mysql"
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
			local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), 8192)
			print("body:",body)
			local i = string.find(body, "password=")
			local j = string.find(body, "&")
			local k = string.find(body, "username=")
			if i==1 then
				password = string.sub(body,i+9,j-1)
				username = string.sub(body,k+9,-1)
			else
				password = string.sub(body,i+9,-1)
				username = string.sub(body,k+9,j-1) 
			end
			print("username",username)
			print("password",password)
			-----------------------------------------------
			db = mysql.connect{	
				host="127.0.0.1",
				port=3306,
				database="logintest",
				user="root",
				password="123",
				max_packet_size = 1024 * 1024
			}


			print("insert into cats (username,password)values(\'"..username.."\', \'"..password.."\')")
			if db then
				print("mysql server connected")
			else
				print("fuck, it cannot connect to the mysql server")
			end
			local res = db:query("drop table if exists cats")
			res = db:query("create table cats ".."(username varchar(10), ".. "password varchar(10))")
			res = db:query("insert into cats (username,password)values(\'"..username.."\', \'"..password.."\')")
			res = db:query("select * from cats")
			print(username,password)
			print ("flag")
			print(dump(res))
			print(unpack(res),res)

			-----------------------------------------------

			if code then
				if code ~= 200 then
					response(id, code)
				else
					local tmp = {}
					if header.host then
						table.insert(tmp, string.format("host: %s", header.host))
					end
					local path, query = urllib.parse(url)
					table.insert(tmp, string.format("path: %s", path))
					if query then
						local q = urllib.parse_query(query)
						for k, v in pairs(q) do
							table.insert(tmp, string.format("query: %s= %s", k,v))
						end
					end
					table.insert(tmp, "-----header----")
					for k,v in pairs(header) do
						table.insert(tmp, string.format("%s = %s",k,v))
					end
					table.insert(tmp, "-----body----\n" .. body)
					response(id, code, table.concat(tmp,"\n"))
				end
			else
				if url == sockethelper.socket_error then
					skynet.error("socket closed")
				else
					skynet.error(url)
				end
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
