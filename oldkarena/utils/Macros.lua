local Macros = {}
local Functions = require "Functions"
--战斗相关
Macros.Instance = -0.00000000001

Macros.FIGHTBOX_STARTTAG = 10000
Macros.FIGHTBOX_ROWTAG = 100
Macros.FIGHTBOX_COLUMNTAG = 1
Macros.STARCOEFFCIENT = 1.35

Macros.FIGHTBOX_WIDTH = 110
Macros.FIGHTBOX_HEIGHT = 110
Macros.FIGHTBOX_COLUMN = 8
Macros.FIGHTBOX_MIN_FRIEND_COLUMN = 5
Macros.FIGHTBOX_MAX_FRIEND_COLUMN = 8
Macros.FIGHTBOX_MIN_ENEMY_COLUMN = 1
Macros.FIGHTBOX_MAX_ENEMY_COLUMN = 4
Macros.FIGHTBOX_SHOWTAG = 12343
Macros.FIGHTBOX_SHOW2TAG = 12344

Macros.FIGHTBOX_ROW = 4
Macros.BACKGROUND_TAG = 19900605

Macros.ItemNumber = 3
Macros.ItemBoxPosX = 90
Macros.ItemBoxPosStartY = 200
Macros.ItemBoxPosDistanceY = 150

Macros.FriendZOrder = 1
Macros.EnemyZOrder = 1

Macros.FIGHTBOX_ACCESSABLETYPE = 10000
Macros.ERROR_TAG = -999999
Macros.Epsilon = 0.00000000001
Macros.KnockOutValue = 19910419

Macros.DeathDelay = 0.1
Macros.ContinuingHealEffectTime = 0
Macros.PoisonEffectTime = 0.05
Macros.BleedingEffectTime = 0.1
Macros.RemoveBuffEffectTime = 0.15
Macros.ItemEffectTime = 0.15--物品作用时间

Macros.BattleStatus = Functions.CreateEnumTable({
	"kFriendMove",
	"kBuffEffect",
	"kCastSkills",
    	-- "kEnemyBuffEffect",
    	-- "kEnemyCastSkills",
    "kEnemyMove",
   	"kEnemyAppear",
   	"kOther",
   	--------------altered here by hd
   	--"kItemMove",--记录是否移动了物品
    	-- "kFriendBuffEffect",
}, -1)
Macros.GameStatus = Functions.CreateEnumTable({
	"kPlaying",
	"kGameOver",
	"kGameWin",
}, -1)
Macros.EffectTypeOnFighter = Functions.CreateEnumTable({
	"eTypeError",
	"eTypeNone",
	"eTypeAttackRelated",
	"eTypeCurrentHpRelated",
	"eTypeTotalHpRelated",
	"eTypeFixed",
	"eTypeDamageRelated",
},-2)
Macros.AnimationEventType = Functions.CreateEnumTable({
	"kAttackNormal",
    "kAttackFlying",
    "kAttackBefore",
    "kAttackAfter",
    "kSmittenFinish",
    "kDeadFinish",
},-1)
-- Macros.SkillHitType = Functions.CreateEnumTable({
-- 	"eNormal",
-- 	"eFlying",
-- },-1)
Macros.SkillHitType = {}
Macros.SkillHitType.eNormal = "ground"
Macros.SkillHitType.eFlying = "air"
-- Z-order
Macros.ZORDER = {}
Macros.ZORDER.ZERO = 0
Macros.ZORDER.POPUP = 50
Macros.ZORDER.T_SideMenu = 50
Macros.ZORDER.T_PortraitMenu = 100
Macros.ZORDER.C_HeadInfoMenu = 25
Macros.ZORDER.F_ComboLabel = 10000

-- touch相关
Macros.TOUCH = {}
Macros.TOUCH.DRAGMINMOVE = 10

-- Combo相关
Macros.ComboTolerenceTime = 5


Macros.FullScreen = {
	{-10,0},{-10,1},{-10,2},{-10,3},{-10,4},{-10,5},{-10,-1},{-10,-2},{-10,-3},{-10,-4},{-10,-5},
	{-9,0},{-9,1},{-9,2},{-9,3},{-9,4},{-9,5},{-9,-1},{-9,-2},{-9,-3},{-9,-4},{-9,-5},
	{-8,0},{-8,1},{-8,2},{-8,3},{-8,4},{-8,5},{-8,-1},{-8,-2},{-8,-3},{-8,-4},{-8,-5},
	{-7,0},{-7,1},{-7,2},{-7,3},{-7,4},{-7,5},{-7,-1},{-7,-2},{-7,-3},{-7,-4},{-7,-5},
	{-6,0},{-6,1},{-6,2},{-6,3},{-6,4},{-6,5},{-6,-1},{-6,-2},{-6,-3},{-6,-4},{-6,-5},
	{-5,0},{-5,1},{-5,2},{-5,3},{-5,4},{-5,5},{-5,-1},{-5,-2},{-5,-3},{-5,-4},{-5,-5},
	{-4,0},{-4,1},{-4,2},{-4,3},{-4,4},{-4,5},{-4,-1},{-4,-2},{-4,-3},{-4,-4},{-4,-5},
	{-3,0},{-3,1},{-3,2},{-3,3},{-3,4},{-3,5},{-3,-1},{-3,-2},{-3,-3},{-3,-4},{-3,-5},
	{-2,0},{-2,1},{-2,2},{-2,3},{-2,4},{-2,5},{-2,-1},{-2,-2},{-2,-3},{-2,-4},{-2,-5},
	{-1,0},{-1,1},{-1,2},{-1,3},{-1,4},{-1,5},{-1,-1},{-1,-2},{-1,-3},{-1,-4},{-1,-5},
	{0,0},{0,1},{0,2},{0,3},{0,4},{0,5},{0,-1},{0,-2},{0,-3},{0,-4},{0,-5},
	{1,0},{1,1},{1,2},{1,3},{1,4},{1,5},{1,-1},{1,-2},{1,-3},{1,-4},{1,-5},
	{2,0},{2,1},{2,2},{2,3},{2,4},{2,5},{2,-1},{2,-2},{2,-3},{2,-4},{2,-5},
	{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,-1},{3,-2},{4,-3},{3,-4},{3,-5},
	{4,0},{4,1},{4,2},{4,3},{4,4},{4,5},{4,-1},{4,-2},{5,-3},{4,-4},{4,-5},
	{5,0},{5,1},{5,2},{5,3},{5,4},{5,5},{5,-1},{5,-2},{6,-3},{5,-4},{5,-5},
	{6,0},{6,1},{6,2},{6,3},{6,4},{6,5},{6,-1},{6,-2},{6,-3},{6,-4},{6,-5},
	{7,0},{7,1},{7,2},{7,3},{7,4},{7,5},{7,-1},{7,-2},{7,-3},{7,-4},{7,-5},
	{8,0},{8,1},{8,2},{8,3},{8,4},{8,5},{8,-1},{8,-2},{8,-3},{8,-4},{8,-5},
	{9,0},{9,1},{9,2},{9,3},{9,4},{9,5},{9,-1},{9,-2},{9,-3},{9,-4},{9,-5},
	{10,0},{10,1},{10,2},{10,3},{10,4},{10,5},{10,-1},{10,-2},{10,-3},{10,-4},{10,-5},
}

return Macros