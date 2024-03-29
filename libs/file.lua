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

local is_unix = package.config and package.config:sub(1, 1) == "/"
local pattern = is_unix and "ls %q" or "dir %q /b"

function file.ScanDir(path)
	local out = {}

	for name in io.popen( format(pattern, path) ):lines() do
		table.insert(out, name)
	end

	return out
end

function file.Exists(path)
	local f = io.open(path, "r")

	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local pattern = "cd \"%s\""

function file.IsDir(path)
	return (os.execute( format(pattern, path) )) or false
end

return file
