return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = true,
    init = function()
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                local listed_buffers = #vim.fn.getbufinfo({buflisted = 1})
                if listed_buffers >= 2 then
                    require("lazy").load({ plugins = { "bufferline.nvim" } })
                    return true
                end
            end,
        })
    end,
    config = function()
        require("bufferline").setup()
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close Buffer" })
    end,
}
