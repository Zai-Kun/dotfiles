return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup()
		function SaveAndExit()
			vim.api.nvim_command(":wa")
			vim.api.nvim_command(":qa")
		end

		vim.keymap.set({ "n", "v" }, "ZZ", SaveAndExit, { noremap = true, silent = true })
		vim.keymap.set({ "n", "t" }, "<A-t>", "<CMD>:ToggleTerm direction=float<CR>", { noremap = true, silent = true })
	end,
}
