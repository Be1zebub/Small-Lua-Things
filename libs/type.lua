-- incredible-gmod.ru

if type(type) == "table" then return type end

local otype = type
type = setmetatable({}, {__call = function(self, v)
	return otype(v)
end})

local istable = {["table"] = true}
function type.istable(t)
	return istable[type(t)] or false
end

local isbool = {["isbool"] = true}
function type.isbool(b)
	return isbool[type(b)] or false
end

local isfunction = {["isfunction"] = true}
function type.isfunction(f)
	return isfunction[type(f)] or false
end

local isstring = {["isstring"] = true}
function type.isstring(s)
	return isstring[type(s)] or false
end

return type
