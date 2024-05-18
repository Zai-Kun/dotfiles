local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-conf")
require("mappings")
require("lazy").setup("plugins")

-- theme
local pick_random_value = function(table)
    math.randomseed(os.time())
    local random_index = math.random(#table)
    return table[random_index]
end

local themes = {
    -- "gruvbox",
    --monokai
    --"monokai-pro-ristretto",
    --"monokai-pro-spectrum",
    --"monokai-pro-classic",
    --"kanagawa",
    "catppuccin-mocha",
    --"citruszest",
}

vim.cmd.colorscheme(pick_random_value(themes))
