local formators = {
	stylua = "lua",
	prettier = {
		"angular",
		"css",
		"flow",
		"graphql",
		"html",
		"json",
		"jsx",
		"javascript",
		"less",
		"markdown",
		"scss",
		"typescript",
		"vue",
		"yaml",
	},
}

local ft = {}
for _, filetypes in pairs(formators) do
	if type(filetypes) == "table" then
		for _, ft_item in ipairs(filetypes) do
			table.insert(ft, ft_item)
		end
	else
		table.insert(ft, filetypes)
	end
end

return {
	{
		"nvimtools/none-ls.nvim",
		ft = ft,
		config = function()
			local null_ls = require("null-ls")
			local sources = {}
			for formatter, _ in pairs(formators) do
				table.insert(sources, null_ls.builtins.formatting[formatter])
			end
			null_ls.setup({
				sources = sources,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		ft = ft,
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = vim.tbl_keys(formators),
			})
		end,
	},
}
