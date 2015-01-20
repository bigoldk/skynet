-- 10.8 by Yi Feng
-- it is used to manage skeleton animation 
-- @params  node:音乐要加到的scene
--           src:音乐的文件名

-- e.g  

local SkeletonManager = {}

-- function SkeletonManager.create(heroName)
-- 	-- 目录结构可能改动
-- 	local json = "spine-animation/"..heroName.."/"..heroName..".json"
-- 	local atlas = "spine-animation/"..heroName.."/"..heroName..".atlas"
-- 	local hero = SkeletonAnimation:createWithFile(json,atlas, 1)
-- 	local dt = 0.2
-- 	local action = {"run","idle","victory","smitten","death","normaltak","superatk"}
-- 	for i = 1,7 do 
-- 		for j= 1,7 do
-- 			hero:setMix(action[i], action[j], dt)
-- 		end
-- 	end
--     return hero
-- end

-- function SkeletonManager.idle(hero)
-- 	hero:addAnimation(0,"idle", true,0)
-- end

-- function SkeletonManager.run(hero)
-- 	hero:addAnimation(0,"run", true,0)
-- end

-- function SkeletonManager.victory(hero)
-- 	hero:addAnimation(0,"victory", true,0)
-- end

-- function SkeletonManager.death(hero)
-- 	hero:addAnimation(0,"death",false,0)
-- end

-- function SkeletonManager.smitten(hero)
-- 	hero:addAnimation(0,"smitten",false,0)
-- end

-- function SkeletonManager.normalatk(hero)
-- 	hero:addAnimation(0,"normalatk",false,0)
-- end

-- function SkeletonManager.superatk(hero)
-- 	hero:addAnimation(0,"superatk",false,0)
-- end

function SkeletonManager.create(skeleton)
	-- 目录结构可能改动
	local heroName = skeleton.name
	local json = "heroassets/spine-animation/"..heroName.."/"..heroName..".json"
	local atlas = "heroassets/spine-animation/"..heroName.."/"..heroName..".atlas"
	local hero
	if io.exists(CCFileUtils:sharedFileUtils():fullPathForFilename(json)) then
		hero = SkeletonAnimation:createWithFile(json,atlas, 1)
	else
		hero = SkeletonAnimation:createWithFile("heroassets/spine-animation/honghaier/honghaier.json", "heroassets/spine-animation/honghaier/honghaier.atlas", 1)
	end
	-- local dt = 0.5
	-- local action = hero.actions
	local loopactions = {"run","idle"}
	local actions = {"run","idle","victory","smitten","death","normalatkQian","normalatkHou","superatkQian","superatkHou"}

	-- local action ={"run","idle","victory","smitten","death","normaltakQian","superatk"}
	for i = 1,8 do 
		for j= 1,2 do
			hero:setMix(loopactions[j], actions[i], 2/30)
			-- hero:setMix(actions[i], loopactions[j], 0.5)
		end
	end
	for i = 1,8 do 
		for j= 1,2 do
			-- hero:setMix(loopactions[j], actions[i], 2/30)
			hero:setMix(actions[i], loopactions[j], 1)
		end
	end
    return hero
end

function SkeletonManager.createDandao(skeleton)
	local heroName = skeleton.name
	local json = "heroassets/spine-animation/"..heroName.."_dandao/"..heroName.."_dandao.json"
	local atlas = "heroassets/spine-animation/"..heroName.."_dandao/"..heroName.."_dandao.atlas"
	local dandao
	if io.exists(CCFileUtils:sharedFileUtils():fullPathForFilename(json)) then
		dandao = SkeletonAnimation:createWithFile(json,atlas, 1)
	else
		dandao = SkeletonAnimation:createWithFile("heroassets/spine-animation/honghaier_dandao/honghaier_dandao.json", "heroassets/spine-animation/honghaier_dandao/honghaier_dandao.atlas", 1)
	end
	-- local dt = 2/30
	-- -- local action = hero.actions
	-- local loopactions = {"run","idle"}
	-- local actions = {"run","idle","victory","smitten","death","normalatkQian","normalatkHou","superatk"}

	-- -- local action ={"run","idle","victory","smitten","death","normaltakQian","superatk"}
	-- for i = 1,8 do 
	-- 	for j= 1,2 do
	-- 		skeleton:setMix(actions[i], loopactions[j], dt)
	-- 	end
	-- end
    return dandao
end

function SkeletonManager.idle(hero,skeleton)
	-- hero:clearTracks()
	-- print(skeleton.name)
	-- print(skeleton.actions.idle)
	hero:setAnimation(0,skeleton.actions.idle[1], true)
end

function SkeletonManager.run(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.run[1], true)
end

function SkeletonManager.victory(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.victory[1], true)
end

function SkeletonManager.death(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.death[1],false)
end

function SkeletonManager.smitten(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.smitten[1],false)
	hero:addAnimation(0,skeleton.actions.idle[1], true,0)
end

function SkeletonManager.normalatkQian(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.normalatkQian[1],false)
end

function SkeletonManager.normalatkHou(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.normalatkHou[1],false)
	hero:addAnimation(0,skeleton.actions.idle[1], true,0)
end

function SkeletonManager.superatkQian(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.superatkQian[1],false)
end

function SkeletonManager.superatkHou(hero,skeleton)
	-- hero:clearTracks()
	hero:setAnimation(0,skeleton.actions.superatkHou[1],false)
	hero:addAnimation(0,skeleton.actions.idle[1], true,0)
end

function SkeletonManager.kongdandao(dandao)
	dandao:setAnimation(0, "kong", true)
end

function SkeletonManager.normaldandao(dandao)
	-- dandao:clearTracks()
	dandao:setAnimation(0, "normalatk", false)
	dandao:addAnimation(0, "kong", true, 0)
end

function SkeletonManager.superdandao(dandao)
	-- dandao:clearTracks()
	dandao:setAnimation(0, "superatk", false)
	dandao:addAnimation(0, "kong", true, 0)
end
return SkeletonManager