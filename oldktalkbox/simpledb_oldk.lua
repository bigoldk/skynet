local skynet = require "skynet"
local db = {}
local tab = 0

local command = {}

function command.GET(tab)
	print("tab",tab)
	if tab == #db then
		return true
	else
		local str = ""
		for i = tab+1,#db do
			local st = db[i][1]
			for j = 2,4 do
				st = st.."="..db[i][j]
			end
			str = str..st.."=&"
		end
		print("str",str)
		return str
	end
end

function command.POST(message,username)
	tab = tab+1
	local num = #db
	db[num+1] = {tab,message,username,os.time()}
	print("hey there")
	return true
end

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		print("fdsafdsaf")
		local f = command[string.upper(cmd)]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)
	skynet.register "SIMPLEDB_OLDK"
end)
