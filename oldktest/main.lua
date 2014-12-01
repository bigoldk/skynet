local skynet = require "skynet"

skynet.start(function()
	print("server starts")
	skynet.newservice("watchdog")

	skynet.exit()
	end
)