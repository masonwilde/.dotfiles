vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })

require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
			{ section = "projects", icon = " ", title = "Projects", indent = 2, padding = 1 },
			{
				text = { { "  Neovim loaded", hl = "footer" } },
				align = "center",
				padding = 1,
			},
		 },
	},
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
