local split = function(value)
	local result = {}
	local i = 0
	for match in string.gmatch(value, "%S+") do
		i = i + 1
		result[i] = match
	end
	return result
end

-- Find a regex in the current buffer.
local function has_match(pattern)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local content = table.concat(lines, "\n")
	return string.gmatch(content, pattern)() ~= nil
end

-- Remove a member from an import line.

vim.api.nvim_create_user_command("ReplaceImportTree", function(opts)
	local args = split(opts.fargs[1])
	local from_member = args[1]
	local to_module = args[2]

	-- check whether there is an import for `from_member`, otherwise return
	local has_from_member = has_match("import {[^}]*%f[%w]" .. from_member .. "%f[%W][^}]*} from .*;")

	if not has_from_member then
		print("No matches found.")
		return
	end

	print("Match found")

	-- use sed to remove `from_member` (including trailing comma) the identified line

	-- check whether `to_module` already exists

	-- does not exist: create empty import statement in new line

	-- use sed to insert `from_member` at the end of the member list in the identified line

	-- ? organize imports using lsp
end, {
	nargs = 1,
	desc = "Custom command to move a module member from one module to another in imports using treesitter.",
})

return {}
