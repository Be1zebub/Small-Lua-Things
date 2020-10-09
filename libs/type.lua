-- incredible-gmod.ru

if type(type) == "table" then return type end

local otype = type
type = setmetatable({}, {__call = function(self, v)
    return otype(v)
end})

local istable = {["table"] = true}
function type.istable(t)
	return type(istable[t]) or false
end

local isbool = {["isbool"] = true}
function type.isbool(t)
	return type(isbool[t]) or false
end

local isfunction = {["isfunction"] = true}
function type.isfunction(f)
	return type(isfunction[t]) or false
end

local isstring = {["isstring"] = true}
function type.isstring(s)
	return type(isstring[t]) or false
end

return type
