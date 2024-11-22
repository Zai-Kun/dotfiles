local excluded_filetypes = {
	"help",
	"alpha",
	"dashboard",
	"NvimTree",
	"Trouble",
	"trouble",
	"lazy",
	"mason",
	"notify",
	"toggleterm",
}

return {
	{
		"lukas-reineke/indent-blankline.nvim",
        event = {"BufReadPost", "BufNewFile"},
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = { filetypes = excluded_filetypes },
		},
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
        event = {"BufReadPost", "BufNewFile"},
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = excluded_filetypes,
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}

