vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })

require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 5000,
		style = "compact",
		top_down = false,
	},
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>nd", function() Snacks.notifier.hide() end, { desc = "Dismiss Notifications" })
