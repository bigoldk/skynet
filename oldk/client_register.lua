local skynet = require "skynet"
local socket = require "clientsocket"
local httpc = require "http.httpc"


skynet.start(function()
	print("let's see what's going on")
	
	local header = {}
	local up = {}
	up["username"] = "Kurt"
	up["password"] = "Cobain"
	local status, body = httpc.post("127.0.0.1:8001","/",up,header)
	-- local status, body = httpc.get("127.0.0.1:8001", "/", header)
	print("[header] =====>")
	for k,v in pairs(header) do
		print(k,v)
	end
	print("[body] =====>", status)
	print(body)

	skynet.exit()
end)
