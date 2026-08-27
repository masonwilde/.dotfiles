vim.pack.add({ { src = "https://github.com/coder/claudecode.nvim" } })

require("claudecode").setup({
	terminal = {
		provider = "snacks",
		-- split_side/split_width_percentage only describe vertical splits, so the
		-- bottom panel has to come from the snacks window options directly.
		snacks_win_opts = {
			position = "bottom",
			height = 0.4,
		},
	},
	diff_opts = {
		layout = "vertical",
	},
})

vim.keymap.set("n", "<leader>a", "<CMD>ClaudeCode<CR>", { desc = "Claude toggle" })
vim.keymap.set("n", "<leader>Af", "<CMD>ClaudeCodeFocus<CR>", { desc = "Claude focus" })
vim.keymap.set("n", "<leader>Ab", "<CMD>ClaudeCodeAdd %<CR>", { desc = "Claude add buffer" })
vim.keymap.set("v", "<leader>As", "<CMD>ClaudeCodeSend<CR>", { desc = "Claude send selection" })
vim.keymap.set("n", "<leader>Aa", "<CMD>ClaudeCodeDiffAccept<CR>", { desc = "Claude accept diff" })
vim.keymap.set("n", "<leader>Ad", "<CMD>ClaudeCodeDiffDeny<CR>", { desc = "Claude reject diff" })
vim.keymap.set("n", "<leader>Ar", "<CMD>ClaudeCode --resume<CR>", { desc = "Claude resume session" })
vim.keymap.set("n", "<leader>Ac", "<CMD>ClaudeCode --continue<CR>", { desc = "Claude continue session" })
vim.keymap.set("n", "<leader>Am", "<CMD>ClaudeCodeSelectModel<CR>", { desc = "Claude select model" })
