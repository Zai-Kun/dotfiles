return {
    "numToStr/Comment.nvim",
    event="BufReadPost",
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
