vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("neo-tree").setup({
	window = {
		mappings = {
			["e"] = function() vim.cmd("Neotree focus filesystem left") end,
			["b"] = function() vim.cmd("Neotree focus buffers left") end,
			["g"] = function() vim.cmd("Neotree focus git_status left") end,
		},
	},
	event_handlers = {
		{
			event = "file_open_requested",
			handler = function()
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
})
