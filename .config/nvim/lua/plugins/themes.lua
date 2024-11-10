return {
	{
		"ellisonleao/gruvbox.nvim",
        lazy = true,
		name = "gruvbox",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
        lazy = true,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"loctvl842/monokai-pro.nvim",
        lazy = true,
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
        lazy = true,
		name = "kanagawa",
		priority = 1000,
	},
    {
        "zootedb0t/citruszest.nvim",
        lazy = true,
        priority = 1000,
    },
}
