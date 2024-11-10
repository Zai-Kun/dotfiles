return {
    "numToStr/Comment.nvim",
    event="BufRead",
    config = function()
        require("Comment").setup({
            toggler = {
                line = "<C-/>",
            },
            opleader = {
                line = "<C-/>",
            },
        })
    end,
}
