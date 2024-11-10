return {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
        {
            "<A-h>",
            "<Cmd>1ToggleTerm direction=horizontal<cr>",
            desc = "Toggle horizontal terminal",
            noremap = true,
            silent = true,
            mode = { "n", "t" },
        },
        {
            "<A-v>",
            "<Cmd>2ToggleTerm direction=vertical size=50<cr>",
            desc = "Toggle vertical terminal",
            noremap = true,
            silent = true,
            mode = { "n", "t" },
        },
        {
            "<A-t>",
            "<Cmd>3ToggleTerm direction=float<cr>",
            desc = "Toggle floating terminal",
            noremap = true,
            silent = true,
            mode = { "n", "t" },
        },
    },
    config = function()
        require("toggleterm").setup()
        function SaveAndExit()
            vim.api.nvim_command(":wa")
            vim.api.nvim_command(":qa")
        end
        vim.keymap.set({ "n", "v" }, "ZZ", SaveAndExit, { noremap = true, silent = true })
    end,
}
