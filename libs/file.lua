-- incredible-gmod.ru

local status, json = pcall(require, "json")
json = status and json or {encode = function(v) return v end, decode = function(v) return v end}

local io, table, format = io, table, string.format

local file = {}

function file.Read(path, json_decode)
	local f = io.open(path, "r")
	if not f then return json_decode and {} or "" end
	
	local content = f:read("*a")
	io.close(f)

	if json_decode then
		return json.decode(content) or ""
	else
		return content or ""
	end
end

function file.Write(path, content, json_encode)
	local f = io.open(path, "w")
	if not f then return false end

	f:write(json_encode and json.encode(content) or content)
	f:close()

	return true
end

local is_unix = package.config:sub(1, 1) == "/"
local pattern = is_unix and "ls \"%s\"" or "dir \"%s\" /b"

function file.ScanDir(path)
    local out = {}

    for fname in io.popen( format(pattern, path) ):lines() do
        table.insert(out, fname)
    end

    return out
end

return file
