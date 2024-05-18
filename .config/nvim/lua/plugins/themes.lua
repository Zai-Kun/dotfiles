return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"loctvl842/monokai-pro.nvim",
		name = "monokai-pro",
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				filter = "classic",
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
	},
    {
        "zootedb0t/citruszest.nvim",
        lazy = false,
        priority = 1000,
    },
}
