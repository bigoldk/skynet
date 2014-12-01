local skynet = require "skynet"
local socket = require "socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local redis = require "redis"


local function response(id, ...)
	local ok, err = httpd.write_response(sockethelper.writefunc(id), ...)
	if not ok then
		-- if err == sockethelper.socket_error , that means socket closed.
		skynet.error(string.format("fd = %d, %s", id, err))		
	end
end


skynet.start(function()
	local conf = {
		host = "127.0.0.1",
		port = 6379,
		db = 0
	}

	local db = redis.connect(conf)
	if db then
		print("db, success? ",db)
	else
		print("db connection failed")
	end

	skynet.dispatch("lua" , function(_,_,id)
		socket.start(id)
		local code,url,method,header,body = httpd.read_request(sockethelper.readfunc(id),8192)
		print (body)
		bodyd = {}
		local fla = string.find(body, "=")
		local en = string.find(body,"&")
		local star = 1
		if fla == nil then
			response(id,code,body.."not standerd")
		else
			while fla do
				if en ~= -1 then
					local key = string.sub(body,star,fla-1)
					local value = string.sub(body,fla+1,en-1)
					bodyd[key] = value
					-- print(key,bodyd[key])
				else
					local key = string.sub(body,star,fla-1)
					local value = string.sub(body,fla+1,en)
					bodyd[key] = value
					-- print(key,bodyd[key])
					break	
				end
				star = en + 1
				fla = string.find(body,"=",star)
				en = string.find(body,"&",star) or -1
			end	
		end

		if next(bodyd)==nil then
			print("nothing here")
		else
			for i in pairs(bodyd) do
				print(i,bodyd[i])
				db:hset("test",i,bodyd[i])
			end
		end

		




		-- response(id,code,"hi there")
	end
	)

	-- skynet.exit()

end
)