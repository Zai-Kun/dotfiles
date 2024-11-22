-- function GetCurrentDiagnostic()
-- 	local bufnr = 0
-- 	local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
-- 	local opts = { ["lnum"] = line_nr }

-- 	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
-- 	if vim.tbl_isempty(line_diagnostics) then
-- 		return
-- 	end

-- 	local best_diagnostic = nil

-- 	for _, diagnostic in ipairs(line_diagnostics) do
-- 		if best_diagnostic == nil or diagnostic.severity < best_diagnostic.severity then
-- 			best_diagnostic = diagnostic
-- 		end
-- 	end

-- 	return best_diagnostic
-- end

-- function GetCurrentDiagnosticString()
-- 	local diagnostic = GetCurrentDiagnostic()

-- 	if not diagnostic or not diagnostic.message then
-- 		return
-- 	end

-- 	local message = vim.split(diagnostic.message, "\n")[1]
-- 	local max_width = vim.api.nvim_win_get_width(0) - 35

-- 	if string.len(message) < max_width then
-- 		return message
-- 	else
-- 		return string.sub(message, 1, max_width) .. "..."
-- 	end
-- end

local lsp = {
	function()
		local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
		if #buf_clients == 0 then
			return ""
		end

		local buf_client_names = {}

		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" and client.name ~= "copilot" then
				table.insert(buf_client_names, client.name)
			end
		end
		local unique_client_names = table.concat(buf_client_names, ", ")
		local language_servers = string.format("[%s]", unique_client_names)
		if language_servers == "[]" then
			return ""
		end
		return language_servers
	end,
	-- color = { gui = "bold" },
}

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_c = { "filename" },
				lualine_x = { "filetype", lsp },
			},
		})
	end,
}
