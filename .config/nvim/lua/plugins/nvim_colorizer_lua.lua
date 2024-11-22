return {
    "NvChad/nvim-colorizer.lua",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("colorizer").setup({
            user_default_options = {
                mode = "foreground",
            },
        })
    end,
}
