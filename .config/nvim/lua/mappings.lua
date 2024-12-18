local map = vim.keymap.set

-- General
local press_key = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local save = function()
    vim.cmd("w")
    press_key("<Esc>")
end

local format = function()
    vim.lsp.buf.format()
    if vim.bo.filetype == "python" then
        vim.cmd("silent! !ruff check --fix --select I -q %")
    end
end

map({ "n", "i", "v", "c" }, "<C-s>", save, { desc = "Save and switch to normal mode", noremap = true })
map({ "n", "i", "v", "c" }, "<C-f>", format, { desc = "Format the current buffer", noremap = true })

map({ "i", "v", "c" }, "<C-b>", function()
    press_key("<Esc>")
end, { desc = "Switch to normal mode", noremap = true })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
map("t", "<C-b>", "<C-\\><C-n>", { noremap = true, silent = true })

map({ "n", "v" }, "<Home>", "^", { noremap = true, desc = "Returns to the last non-empty character" })

map({ "v", "n" }, "<C-Home>", function()
    press_key("gg0")
end, { noremap = true })
map({ "v", "n" }, "<C-S-Home>", function()
    press_key("gg0")
end, { noremap = true })

map(
    "i",
    "<Home>",
    "<CMD>:normal! ^<CR>",
    { noremap = true, silent = true, desc = "Returns to the last non-empty character in insert mode" }
)

map("x", "<leader>p", '"_dP', { noremap = true, desc = "Paste without copying the content" })
map(
    "n",
    "<leader>r",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Replace word under cursor" }
)
map("n", "n", "nzzzv", { noremap = true, desc = "Center the screen after jumping to the next match" })
map("n", "N", "Nzzzv", { noremap = true, desc = "Center the screen after jumping to the previous match" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", ";", ":")

-- Indentation
map("x", "<Tab>", ">gv", { noremap = true })
map("x", "<S-Tab>", "<gv", { noremap = true })

-- Scrolling
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "<C-a>", "<C-u>zz", { noremap = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true })

-- Moving selected block of code up and down
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { noremap = true })

-- Moving between windows
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
