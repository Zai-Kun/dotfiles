return {
	"roobert/activate.nvim",
    lazy = true,
	keys = {
		{
			"<leader>P",
			'<CMD>lua require("activate").list_plugins()<CR>',
			desc = "Plugins",
		},
	},
	dependencies = {
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
}
