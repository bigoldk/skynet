--
-- Author: Yiran WANG
-- Date: 2014-09-18 20:49:21
--

local BattleInformation = {
	BaseInfos = {
		Chapter = 1,
		Mission = 1,
		Name = "竞技场",
		Description = "just for test！",
		EnergyCosts = 0,
		Exp = 0,
		-- ExpBaseValue = 100,
		-- GoldBaseValue = 100,
	},
	
	ComboParams = {
		capacity = {5,10,20},
		effect = {effectobject = {"DPS", "BUFF", "TANK"},
				effect = { 
					{
						Atk = 10,
					},
					{
						Atk = 15,
					},
					{
						Atk = 20,
					},
				  },},
		release = {releaseType = "damage",
				   releaseValue = 0.5},
	},
	
	EnemyInfos = {
		EnemyList = {
			
			{
				Fighter = {Name = "BaiGuJing", 
				 		Level = 1, Star = 1, 
				 		Gift = "None", 
				 		Item = {}},
				Index = 1,
				onStage = 0, 
				initPos = {4, 3},
			},
			
			{
				Fighter = {Name = "XiongPiGuai", 
					Level = 1, Star = 1, 
					Gift = "None", 
					Item = {}},
				Index = 2,
				onStage = 0, 
				initPos = {3, 1},
			},
			{
				Fighter = {Name = "BaiLuJing", 
				 		Level = 1, Star = 1, 
				 		Gift = "None", 
				 		Item = {}},
				Index = 3,
				onStage = 0, 
				initPos = {1, 3},
			},
			
			{
				Fighter = {Name = "BeiHaiLongNv", 
					Level = 1, Star = 1, 
					Gift = "None", 
					Item = {}},
				Index = 4,
				onStage = 0, 
				initPos = {1, 1},
			},
			{
				Fighter = {Name = "BaiXiangWang", 
				 		Level = 1, Star = 1, 
				 		Gift = "None", 
				 		Item = {}},
				Index = 5,
				onStage = 0, 
				initPos = {1, 4},
			},

		},
		EnemyCaptains = 1,
	},
	
	GroundInfos = {
		Ground = {
			{1,0,1,0,0,2,0,0,},
			{0,0,0,0,0,0,0,0,},
			{0,0,0,0,0,0,2,0,},
			{0,7,0,0,0,0,0,0,},
		},
		BattleFieldType = "Normal",
	},
	
	ItemInfos = {
		RewardsZhuangbei = {1},
	        RewardsFood = {
	                {name = "doufu",number = 1, prob = 80},
	                {name = "lajiao",number = 1, prob = 80},
	                {name = "zhurou",number = 1, prob = 80},
			{name = "mianfen",number = 1, prob = 80},
	              },
	},
	
}

return BattleInformation