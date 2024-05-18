return {
    "numToStr/Comment.nvim",
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
