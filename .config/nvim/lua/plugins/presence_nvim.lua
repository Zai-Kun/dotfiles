return {
	"andweeb/presence.nvim",
    event = {"BufReadPost", "BufNewFile"},
	config = function()
		require("presence").setup({
			neovim_image_text = "The One True Text Editor",
			main_image = "file",
		})
	end,
}
