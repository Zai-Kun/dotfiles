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
require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
})

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

-- For big files
local function disable_syntax_treesitter()
    print("Big file, disabling syntax, treesitter, and folding")

    if vim.fn.exists(":TSBufDisable") == 2 then
        vim.cmd("TSBufDisable autotag")
        vim.cmd("TSBufDisable highlight")
    end

    vim.opt.foldmethod = "manual"
    -- vim.cmd("syntax clear")
    -- vim.cmd("syntax off")
    -- vim.cmd("filetype off")
    vim.opt.undofile = false
    vim.opt.swapfile = false
    vim.opt.loadplugins = false
end

vim.api.nvim_create_augroup("BigFileDisable", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
    group = "BigFileDisable",
    pattern = "*",
    callback = function()
        if vim.fn.getfsize(vim.fn.expand("%")) > 512 * 1024 then
            disable_syntax_treesitter()
        end
    end,
})

-- Saving the undolist for future sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
