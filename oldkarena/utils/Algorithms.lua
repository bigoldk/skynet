-- By Yi Feng
--封装了一些算法,（按等级，名字排序，etc）
local Algorithms = {}

function Algorithms.SortDefault(a,b) -- level 降序 name 升序 
	if a.Level == b.Level then
		return a.Name<b.Name 
	else
		return a.Level>b.Level
	end
end

function Algorithms.SortByName(a,b) -- name 升序 
		return a.Name<b.Name
end

function Algorithms.SortByIndex1(a,b) -- index[1] -- name 升序 
		return a[1]<b[1]
end

function Algorithms.SortByIndex2(a,b) -- ；index[2] -- level down index[1] -- name 升序 
	if a[2] == b[2] then
		return a[1]<b[1]
	else
		return a[2]>b[2]
	end
end

return Algorithms