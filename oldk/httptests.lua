local skynet = require "skynet"
local httpc = require "http.httpc"

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

skynet.start(function()
	-- print("GET baidu.com")
	local header = {}
	local values={}
	values["request"] = "liaotiangetprivate"
	values["tab"] = 0
	values["to"] = "Kurt"
	values["username"] = "Kurt"
	values["message"] = "你好"
	-- values["password"] = "Curtis"
	-- values["account"] = emailEncode("jfd.34_3@126.com")
	-- values["data"] = string.rep("b",100)

	local status, body = httpc.post("127.0.0.1:8001","/",values)
	print("[header] =====>")
	for k,v in pairs(header) do
		print(k,v)
	end
	print("[body] =====>", status)
	print(body)

	skynet.exit()
end)
