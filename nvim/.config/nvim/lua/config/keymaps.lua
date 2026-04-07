vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Neo-tree
map("n", "<leader>t", "<CMD>Neotree toggle<CR>", "Neotree toggle")
map("n", "<leader>r", "<CMD>Neotree focus<CR>", "Neotree focus")

-- Splits
map("n", "<leader>o", "<CMD>vsplit<CR>", "Vertical split")
map("n", "<leader>p", "<CMD>split<CR>", "Horizontal split")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")
