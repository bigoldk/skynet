local skynet = require "skynet"
local socket = require "socket"
local httpd = require "http.httpd"
local httpc = require "http.httpc"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
local table = table
local string = string
local i=0
local mode = ...
if mode == "agent" then
	-- print(mode)

	local function response(id, ...)
		local ok, err = httpd.write_response(sockethelper.writefunc(id), ...)
		if not ok then
			-- if err == sockethelper.socket_error , that means socket closed.
			skynet.error(string.format("fd = %d, %s", id, err))
		end
	end
	skynet.start(function()
		skynet.dispatch("lua", function (_,_,id)
			

			socket.start(id)
			-- limit request body size to 8192 (you can pass nil to unlimit)
			local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), 8192)
			print("code",code)
			print("url",url)
			print("method",method)
			print("header",header)
			print("body",body)
			if code then
				if code ~= 200 then
					response(id, code)
				else
					local body2
					local ID_i, ID_j = string.find(body, "UserID=")
					local _, ID_k = string.find(body,"&",ID_j)
					local UserID = string.sub(body,ID_j+1,ID_k-1)
					print("userid=",UserID)
					local i, j = string.find(body, "Request=")
					if string.sub(body,j+1,j+6) == "update" then
						header2={}
						local a ={userid = UserID}
						local status2, bodyfromupdateserver = httpc.post("118.192.77.18:8001", "/test_http/code", a, header2)
						local i, j =string.find(bodyfromupdateserver, "body----\n")
						body2 = string.sub(bodyfromupdateserver,j+1,-1)
					end


					local temp = {}
					if header.host then
						table.insert(temp, string.format("host: %s", header.host))
					end

					local path, query = urllib.parse(url)
					table.insert(temp, string.format("path: %s", path))
					if query then
						local q = urllib.parse_query(query)
						for k, v in pairs(q) do
							table.insert(temp, string.format("query: %s= %s", k,v))
						end
					end
					table.insert(temp, "-----header----")
					for k,v in pairs(header) do
						table.insert(temp, string.format("%s = %s",k,v))
					end
					table.insert(temp, "-----body----\n" .. body2)
					-- local file = assert(io.open("."..path,'r'))
					-- local lbody = file:read("*all")
					-- print(lbody)
					-- table.insert(tmp, "-----body----\n" .. lbody)					
					response(id, code, table.concat(temp,"\n"))
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
		local id = socket.listen("127.0.0.1", 2013)
		-- local id = socket.listen("0.0.0.0", 8001)
		-- print("flag")

		socket.start(id , function(id, addr)
			--print("hey you")
			skynet.error(string.format("%s connected, pass it to agent :%08x", addr, agent[balance]))
			skynet.send(agent[balance], "lua", id)
			balance = balance + 1
			if balance > #agent then
				balance = 1
			end
		end)
		-- print("flag")

	end)

end