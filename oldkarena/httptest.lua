local skynet = require "skynet"
local httpc = require "http.httpc"

skynet.start(function()
	-- print("GET baidu.com")
	local header = {}
	local values={}
	values["request"] = "arena"
	values["username"] = "Ian"
	values["opponent"] = "Kurt"
	values["attacker1"] = "BaiGuJing"
	values["attacker1pos"] = "43"
	values["attacker2"] = "XiongPiGuai"
	values["attacker2pos"] = "31"
	values["attacker3"] = "BaiLuJing"
	values["attacker3pos"] = "13"
	values["attacker4"] = "BeiHaiLongNv"
	values["attacker4pos"] = "11"
	values["attacker5"] = "BaiXiangWang"
	values["attacker5pos"] = "14"
	values["defencer1"] = "LingGanDaWang"
	values["defencer1pos"] = "51"
	values["defencer2"] = "XiongPiGuai"
	values["defencer2pos"] = "52"
	values["defencer3"] = "YuTuJing"
	values["defencer3pos"] = "63"
	values["defencer4"] = "DongHaiLongNv"
	values["defencer4pos"] = "64"
	values["defencer5"] = "BaiLongMa"
	values["defencer5pos"] = "62"


	local status, body = httpc.post("127.0.0.1:8001","/",values)
	print("[header] =====>")
	for k,v in pairs(header) do
		print(k,v)
	end
	print("[body] =====>", status)
	print(body)

	skynet.exit()
end)
