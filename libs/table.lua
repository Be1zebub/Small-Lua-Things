local function DoRecursive(tab, callback, onfinish)
    local k, v = next(tab)
    if not v then
        if onfinish then onfinish() end
        return
    end
    tab[k] = nil

    callback(k, v, function()
        DoRecursive(tab, callback, onfinish)
    end)
end

function table.Recursive(tab, callback, onfinish)
    DoRecursive(table.Copy(tab), callback, onfinish)
end

function table.Filter(table, handle)
	for k, v in pairs(table) do
		if not handle(v, k) then
			table[k] = nil
		end
	end
end

function table.Shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
  	end
  	
  	return tbl
end

function table.Copy(t, lookup_table)
	if t == nil then return nil end

	local copy = {}
	setmetatable(copy, debug.getmetatable(t))
	for i, v in pairs(t) do
		if not istable(v) then
			copy[ i ] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = table.Copy(v, lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end

function table.HasValue(t, val)
	for k, v in pairs(t) do
		if v == val then return true, k end
	end
  
	return false
end

function table.GetKeys(tab)
	local keys = {}
	local id = 1

	for k, v in pairs(tab) do
		keys[id] = k
		id = id + 1
	end

	return keys
end

local table_Count, random = table.Count, table.random
function table.Random(t)
	local rk = random(1, table_Count(t))
	local i = 1
	for k, v in pairs(t) do
		if i == rk then return v, k end
		i = i + 1
	end
end

function table.Count(t)
	local i = 0
	for k in pairs(t) do i = i + 1 end
	return i
end

table.forEach = function(t, c)
	for k, v in pairs(t) do
		c(v, k)
	end
end
