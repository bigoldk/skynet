local skynet = require "skynet"
local socket = require "socket"

skynet.start(function()
	local agent = {}
	for i=1,20 do
		print("agent"..i)
		agent[i]=skynet.newservice("agent")
	end
	
	local balence = 1
	local id = socket.listen("0.0.0.0", 8001)
	socket.start(id, function(id,addr)
		skynet.send(agent[balence],"lua",id)
		balence = balence +1
		if balence > #agent then
			balence = 1
		end
	end)
	end
)