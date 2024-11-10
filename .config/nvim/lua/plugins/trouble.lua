return {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        {
            "<leader>t",
            ":Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
    },
    config = function()
        require("trouble").setup()
    end,
}
