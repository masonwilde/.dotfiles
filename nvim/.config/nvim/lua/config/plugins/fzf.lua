vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local fzf = require("fzf-lua")
fzf.setup({})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", fzf.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
