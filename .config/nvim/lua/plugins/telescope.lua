return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local configs = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", configs.find_files, {})
			vim.keymap.set("n", "<leader>fg", configs.live_grep, {})
			vim.keymap.set("n", "<leader>b", configs.buffers, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
