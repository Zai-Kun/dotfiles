return {
    "numToStr/Comment.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("Comment").setup({
            ignore = "^$",
        })
        local K = vim.keymap.set
        K(
            'n',
            "<C-/>",
            '<Plug>(comment_toggle_linewise_current)',
            { desc = 'Comment toggle linewise' }
        )
        K(
            'x',
            "<C-/>",
            '<Plug>(comment_toggle_linewise_visual)gv',
            { desc = 'Comment toggle blockwise (visual)' }
        )
    end,
}
