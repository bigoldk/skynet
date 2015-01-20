--
-- Author: Wu Jian
-- Date: 2014-07-17 12:02:05
--
local GameStatus = {}
GameStatus._music_on = true
--GameStatus._sound_on = true

GameStatus.PlayerName = 'wqc'

GameStatus.Money = 100000  --基础金钱数量
GameStatus.CurrentEnergy = 45
GameStatus.TotalEnergy = 199

GameStatus.AllHeros = {
	{Name = "LingGanDaWang", 
	Level = 1, 
	Exp = 0,
	Star = 1, 
	Colour = 1,
	Gift = {"Fire", 0, 0, 0, 0, 0},
	--Head = "Caomao",
	--Armor = "Caoqun",
	--Weapon = "Mujian",
	--Shoes = "Caoxie",
	Src = "linggandawang.png"},   

	{Name = "XiongPiGuai", 
	Level = 3, 
	Exp = 0,
	Star = 1,
	Colour = 1,
	Gift = {"Fire", 0, 0, 0, 0, 0},
	--Head = "Caomao",
	--Armor = "Caoqun",
	--Weapon = "Mufu",
	--Shoes = "Caoxie",
	Src = "xiongpiguai.png"}, 

	{Name = "YuTuJing", 
	Level = 4, 
	Exp = 0,
	Star = 1,
	Colour = 1,
	Gift = {"Fire", 0, 0, 0, 0, 0},
	--Head = "Caomao",
	--Armor = "Caoqun",
	--Weapon = "Mufu",
	--Shoes = "Caoxie",
	Src = "yutujing.png"},
	
	{Name = "DongHaiLongNv", 
	Level = 2, 
	Exp = 0,
	Star = 1,
	Colour = 1,
	Gift = {"Fire", 0, 0, 0, 0, 0},
	--Head = "Caomao",
	--Armor = "Caoqun",
	--Weapon = "Mufu",
	--Shoes = "Caoxie",
	Src = "donghailongnv.png"}, 

	{Name = "BaiLongMa", 
	Level = 1, 
	Exp = 0,
	Star = 1,
	Colour = 1, 
	Gift = {"Fire", 0, 0, 0, 0, 0},
	--Head = "Caomao",
	--Armor = "Caoqun",
	--Weapon = "Mufu",
	--Shoes = "Caoxie",
	Src = "bailongma.png"},  

}

--物品名称和作用效果，暂未使用。
GameStatus.Items = {
	{"炸弹","群伤敌人"},
	{"回魂丹","恢复己方生命值"},
	{"无敌咒符","己方角色一段时间内无敌"},
}

GameStatus.RandomNames = {
	"一只草泥马",
	"两只小蝴蝶",
	"三个大傻子",
	"四驾老马车",
	"武松要打虎",
	"六小真龄童",
	"下凡七仙女",
	"过海八神仙",
	"九头情未了",
	"十面埋伏深",
}
GameStatus.MissionStars = {
	3,3,3,2,2,1,2,1,0,
}
GameStatus.MissionNames = {
	"平原地带",
	"小山丘",
	"森林边缘",
	"丛林之夜",
	"林间空地",
	"小木屋",
	"小红帽",
	"平静的湖水",
	"巨龙来袭",
}
GameStatus.MissionDescriptions = {
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"这是森林中的第一个夜晚，众人睡梦正酣却听到...",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
	"经过了一天的修正，战士们决定继续行军寻找敌人的踪迹。",
}
GameStatus.MissionRemainTimes = {
	-1, -1, -1, -1, -1, -1, -1, -1, 3,
}
GameStatus.MissionEnergyCosts = {
	5, 5, 5, 5, 5, 5, 5, 5, 10,
}
GameStatus.MissionRewards = {
	{3,4,},
	{3,4,5,},
	{4,5,},
	{3,4,5,6,},
	{3,4,5,6,7,},
	{5,6,7,},
	{3,4,7,},
	{3,7,},
	{3,6,7,},
}
GameStatus.MissionAchievements = {

}
GameStatus.TeamMembers = {
	{
		{
			Fighter = GameStatus.AllHeros[1],
			onStage = 0,
			initPos = {5, 1},
		},
		{
			Fighter = GameStatus.AllHeros[2],
			onStage = 0,
			initPos = {5, 2},
		},
		{
			Fighter = GameStatus.AllHeros[3],
			onStage = 0,
			initPos = {6, 2},
		},
		{
			Fighter = GameStatus.AllHeros[4],
			onStage = 0,
			initPos = {6, 3},
		},
		{
			Fighter = GameStatus.AllHeros[5],
			onStage = 0,
			initPos = {6, 4},
		},
	},
	
}
GameStatus.TeamCaptains = 1
GameStatus.MissionEnemies = {
	-- 教学：拖曳英雄
	-- Item 是怪物死亡后掉落的物品
	{
		{
		 Fighter = {Name = "NO_01", Level = 1, Star = 1, Gift = "None", Item = "b_addstone1.png"},
		 onStage = 0, 
		 initPos = {4, 3},
		 isboss = true,
		},
		{
		 Fighter = {Name = "NO_02", Level = 1, Star = 1, Gift = "None", Item = "b_addenergy1.png"},
		 onStage = 0, 
		 initPos = {3, 1},
		},
		{
		 Fighter = {Name = "HuLi", Level = 1, Star = 1, Gift = "None", Item = "b_addenergy1.png"},
		 onStage = 0, 
		 initPos = {1, 1},
		}
	},
}
GameStatus.MissionEnemyCaptains = {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
}

GameStatus.Farm = {
	
}

GameStatus.Farm.Shop = {
    item = {},
	time = {9,15,18,21}
}

GameStatus.Farm.ChuanCaiGuan = {
    createtime = nil,
    queuetime = {},
    product = {},
    cook = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"mapodoufu","huiguorou","chuanxianglaziji","shuizhuniurou","malaxiangguo"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.HaiXianCheng = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"meiweixiawan","pijiuyu","roumohaishen","haixianzhou","fotiaoqiang"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.DianXinPu = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"chuantongcaozigao","pingguopai","shuijingnaihuangbao","buding","qiancengluobosu"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.DianXinPu = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"chuantongcaozigao","pingguopai","shuijingnaihuangbao","buding","qiancengluobosu"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.YiPinShiFu = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"yipinjiaozi","muxurou","pijiuji","zhajiangmian","tudouweiniunan","zibuyangroubao","yipindoufu"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.YuSuZhai = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"jiachangdoufu","dafengshou","youpomian","huluobobaozi","zhasuji","nanguayumizhou","zhusunmeirongbao"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.XiCanTing = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"yidalimian","sanwenyushala","hanbaobao","xilengpadingshi","zhizunpisa"},
    zhanggui = "",
    updating = false
}

GameStatus.Farm.XiaoChiFang = {
    createtime = nil,
    queuetime = {},
	duilie = {{src="empty"},{src="empty"},{src="empty"}},
    caipu = {"lazhiroujiamo","basishuiguo","xiangcongjidanbing","zhajiliu","choudoufu","jianbingguozi"},
    zhanggui = "",
    updating = false
}

GameStatus.Item = {
	
}

-- 战斗用物品
GameStatus.FightItem = {
    mapodoufu = 1,
    yipinjiaozi = 1,
    lazhiroujiamo = 1,
    -- mianfen = 1,
}

GameStatus.Food = {
    mianfen = {number = 0, src = "mianfen.png", time = 10},
    zhurou = {number = 10, src = "zhurou.png", time = 10},
    jidan = {number = 0, src = "jidan.png", time = 10},
    tiaoliao = {number = 10, src = "tiaoliao.png", time = 10},
	lajiao = {number = 10, src = "lajiao.png", time = 10},
	qingcai = {number = 0, src = "qingcai.png", time = 10},
	doufu = {number = 10, src = "doufu.png", time = 10},
	yumi = {number = 0, src = "yumi.png", time = 10},
	xia = {number = 0, src = "xia.png", time = 10},
	muer = {number = 0, src = "muer.png", time = 10},
	niurou = {number = 0, src = "niurou.png", time = 10},
	jirou = {number = 0, src = "jirou.png", time = 10},
	shuiguo = {number = 0, src = "shuiguo.png", time = 10},
	cong = {number = 0, src = "cong.png", time = 10},
	luobo = {number = 0, src = "luobo.png", time = 10},
	haishen = {number = 0, src = "haishen.png", time = 10},
	huanggua = {number = 0, src = "huanggua.png", time = 10},
	chaotianjiao = {number = 0, src = "chaotianjiao.png", time = 10},
	yu = {number = 0, src = "yu.png", time = 10},
	daomi = {number = 0, src = "daomi.png", time = 10},
	jiu = {number = 0, src = "jiu.png", time = 10},
	niunai = {number = 0, src = "niunai.png", time = 10},
	huluobo = {number = 0, src = "huluobo.png", time = 10},
	jipinlajiao = {number = 0, src = "jipinlajiao.png", time = 10},
	mogu = {number = 0, src = "mogu.png", time = 10},
	yangrou = {number = 0, src = "yangrou.png", time = 10},
	nangua = {number = 0, src = "nangua.png", time = 10},
	fengmi = {number = 0, src = "fengmi.png", time = 10},
	haidai = {number = 0, src = "haidai.png", time = 10},
	tudou = {number = 0, src = "tudou.png", time = 10},
	pangxie = {number = 0, src = "pangxie.png", time = 10},
	zhusun = {number = 0, src = "zhusun.png", time = 10},
	shuizhuniurou = {number = 0, src = "shuizhuniurou.png", time = 20, construct = {niurou = 2, tiaoliao = 2, chaotianjiao = 3}},
    mapodoufu = {number = 0, src = "mapodoufu.png", time = 20, construct = {doufu = 3, lajiao = 3, zhurou = 2}},
    chuanxianglaziji = {number = 0, src = "chuanxianglaziji.png", time = 10, construct = {jirou = 3, chaotianjiao = 3, mianfen = 2}},
    huiguorou = {number = 0, src = "huiguorou.png", time = 30, construct = {zhurou = 2, lajiao = 2, tiaoliao = 2}},
    malaxiangguo = {number = 0, src = "malaxiangguo.png", time = 20, construct = {jirou = 2, zhusun = 2, jipinlajiao = 2,qingcai = 3}},
    meiweixiawan = {number = 0, src = "meiweixiawan.png", time = 20, construct = {xia = 3, zhurou = 1, mianfen = 2}},
    pijiuyu = {number = 0, src = "pijiuyu.png", time = 20, construct = {yu = 3, lajiao = 1, jiu = 2}},
    roumohaishen = {number = 0, src = "roumohaishen.png", time = 10, construct = {haishen = 3, cong = 3, zhurou = 2}},
    haixianzhou = {number = 0, src = "haixianzhou.png", time = 20, construct = {daomi = 3, xia = 2, pangxie = 1}},
    fotiaoqiang = {number = 0, src = "fotiaoqiang.png", time = 20, construct = {haishen = 3, doufu = 2, haidai = 2,qingcai = 2,zhusun = 1}},
    chuantongcaozigao = {number = 0, src = "chuantongcaozigao.png", time = 20, construct = {mianfen = 4, jidan = 2, tiaoliao = 1}},
    pingguopai = {number = 0, src = "pingguopai.png", time = 20, construct = {mianfen = 3,shuiguo = 2}},
    shuijingnaihuangbao = {number = 0, src = "shuijingnaihuangbao.png", time = 20, construct = {mianfen = 3, niunai = 2, jidan = 2}},
    buding = {number = 0, src = "buding.png", time = 20, construct = {mianfen = 2, niunai = 2, jidan = 2, fengmi = 2}},
    qiancengluobosu = {number = 0, src = "qiancengluobosu.png", time = 20, construct = {mianfen = 2, luobo = 2, fengmi = 1, jidan = 1}},
    yipinjiaozi = {number = 0, src = "yipinjiaozi.png", time = 20, construct = {zhurou = 3, tiaoliao = 2, mianfen = 3}},
    muxurou = {number = 0, src = "muxurou.png", time = 20, construct = {zhurou = 2, jidan = 2, muer = 1, huanggua = 2}},
    pijiuji = {number = 0, src = "pijiuji.png", time = 10, construct = {jirou = 3, jiu = 2, qingcai = 1}},
    zhajiangmian = {number = 0, src = "zhajiangmian.png", time = 20, construct = {zhurou = 1, huanggua = 2, luobo = 1, mianfen = 4}},
    tudouweiniunan = {number = 0, src = "tudouweiniunan.png", time = 20, construct = {tudou = 3, niurou = 2, tiaoliao = 2}},
    zibuyangroubao = {number = 0, src = "zibuyangroubao.png", time = 20, construct = {yangrou = 3, luobo = 3, qingcai = 2}},
    yipindoufu = {number = 0, src = "yipindoufu.png", time = 20, construct = {doufu =5, haishen = 1, xia = 2, pangxie = 1, mogu = 2}},
    jiachangdoufu = {number = 0, src = "jiachangdoufu.png", time = 10, construct = {doufu = 3, muer = 1, qingcai = 2}},
    dafengshou = {number = 0, src = "dafengshou.png", time = 20, construct = {yumi = 2, huanggua = 3, qingcai = 2}},
    youpomian = {number = 0, src = "youpomian.png", time = 20, construct = {mianfen = 3, lajiao = 2, cong = 1, tiaoliao = 1}},
    huluobobaozi = {number = 0, src = "huluobobaozi.png", time = 10, construct = {mianfen = 3, luobo = 3, cong = 1}},
    zhasuji = {number = 0, src = "zhasuji.png", time = 20, construct = {doufu = 3, mogu = 2}},
    nanguayumizhou = {number = 0, src = "nanguayumizhou.png", time = 20, construct = {daomi = 3, nangua = 2, yumi = 2}},
    zhusunmeirongbao = {number = 0, src = "zhusunmeirongbao.png", time = 20, construct = {zhusun = 3, qingcai = 2, mogu = 2, luobo = 2}},
    yidalimian = {number = 0, src = "yidalimian.png", time = 20, construct = {mianfen = 3, jidan = 2, zhurou = 2}},
    sanwenyushala = {number = 0, src = "sanwenyushala.png", time = 20, construct = {qingcai = 3, shuiguo = 2, yu = 1}},
    hanbaobao = {number = 0, src = "hanbaobao.png", time = 20, construct = {jidan = 1, niurou = 2, mianfen = 3, huanggua = 1}},
    xilengpadingshi = {number = 0, src = "xilengpadingshi.png", time = 20, construct = {niurou = 3, mianfen = 2, qingcai = 2, tudou = 1}},
    zhizunpisa = {number = 0, src = "zhizunpisa.png", time = 20, construct = {mianfen = 5, jirou = 3, tudou = 2, mogu = 2, qingcai = 1}},
    lazhiroujiamo = {number = 0, src = "lazhiroujiamo.png", time = 20, construct = {zhurou = 2, mianfen = 3, qingcai = 1}},
    basishuiguo = {number = 0, src = "basishuiguo.png", time = 20, construct = {shuiguo = 4, tiaoliao = 1}},
    xiangcongjidanbing = {number = 0, src = "xiangcongjidanbing.png", time = 10, construct = {mianfen = 4, cong = 1, jidan = 2}},
    zhajiliu = {number = 0, src = "zhajiliu.png", time = 20, construct = {jirou = 3, jidan = 1, mianfen = 2}},
    choudoufu = {number = 0, src = "choudoufu.png", time = 20, construct = {doufu = 3, tiaoliao = 2, jipinlajiao = 1}},
    jianbingguozi = {number = 0, src = "jianbingguozi.png", time = 20, construct = {mianfen = 3, jidan = 1, tiaoliao = 1, jipinlajiao = 1}},
}
-- function GameStatus.SetMusicOn( flag )
-- 	_music_on = flag
-- end
-- function GameStatus.SetSoundOn( flag )
-- 	_sound_on = flag
-- end
-- function GameStatus.GetSoundOn()
-- 	return _sound_on
-- end
-- function GameStatus.GetMusicOn()
-- 	return _music_on
-- end

return GameStatus