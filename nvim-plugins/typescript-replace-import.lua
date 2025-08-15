local split = function(value)
	local result = {}
	local i = 0
	for match in string.gmatch(value, "%S+") do
		i = i + 1
		result[i] = match
	end
	return result
end

local callback = function(opts)
	local args = split(opts.fargs[1])
	print(args[1], args[2])
	local search_pattern = "\\(import {.*\\)\\(" .. args[1] .. "\\),\\? \\(.*} from '.*';\\)"
	local replace_pattern = "\\1\\3\rimport { \\2 } from '" .. args[2] .. "';"
	local command = "s/" .. search_pattern .. "/" .. replace_pattern .. "/c"
	-- print("search pattern:", string.gsub(search_pattern, "\r", "\\r"))
	-- print("replace pattern:", string.gsub(replace_pattern, "\r", "\\r"))
	-- print("command:", string.gsub(command, "\r", "\\r"))
	vim.api.nvim_command(command)
end

vim.api.nvim_create_user_command("ReplaceImport", callback, {
	nargs = 1,
	desc = "Custom command to move a module member from one module to another in imports.",
})

return {}
