-- 9.3 by Yi Feng
-- it is used to manage background music
-- @params  node:音乐要加到的scene
--           src:音乐的文件名

-- e.g  MusicManager.new(self,"anhao.mp3") in ctor() of the scene

local MusicManager = class("MusicManager")

function MusicManager:ctor(node, src)
	local srcName = src
	audio.preloadMusic(srcName)
	local function music(event) 
		if event.name == "enter" then
			audio.playMusic(srcName, true)
			if not GameData.GameStatus._music_on then
				audio.pauseMusic()
			end
		end
		if event.name == "exit" then
			-- true mean release data
			audio.stopMusic(true)
			audio.stopAllSounds()
			
		end
	end
	node:addNodeEventListener(cc.NODE_EVENT,music)
end

return MusicManager