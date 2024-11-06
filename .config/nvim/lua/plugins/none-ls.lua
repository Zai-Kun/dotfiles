return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    -- null_ls.builtins.formatting.black,
                    -- null_ls.builtins.formatting.isort,
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "stylua", "black", "isort", "ruff", "prettier" },
            })
        end,
    },
}
