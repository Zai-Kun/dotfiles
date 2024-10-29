local map = vim.keymap.set

-- General
local press_key = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local save_and_format = function()
	vim.lsp.buf.format()
	vim.cmd("w")
	press_key("<Esc>")
end

map({ "n", "i", "v", "c" }, "<C-s>", save_and_format, { desc = "Format, save , and switch to normal mode" })
map({ "i", "v", "c" }, "<C-b>", function()
	press_key("<Esc>")
end, { desc = "Switch to normal mode" })

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

map("x", "<Tab>", ">gv")
map("x", "<S-Tab>", "<gv")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-a>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
