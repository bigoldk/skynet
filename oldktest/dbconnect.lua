local skynet = require "skynet"
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
		print("redis connection success")
	else
		print("redis connection failed")
		response(id,code,"server error,hold on please")
	end

end)