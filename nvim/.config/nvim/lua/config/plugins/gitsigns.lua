vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })

local gitsigns = require("gitsigns")

gitsigns.setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	current_line_blame = false,
})

local function selected_range()
	return { vim.fn.line("."), vim.fn.line("v") }
end

vim.keymap.set("n", "]h", function() gitsigns.nav_hunk("next") end, { desc = "Next hunk" })
vim.keymap.set("n", "[h", function() gitsigns.nav_hunk("prev") end, { desc = "Previous hunk" })

vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("v", "<leader>gs", function() gitsigns.stage_hunk(selected_range()) end, { desc = "Stage selection" })
vim.keymap.set("v", "<leader>gr", function() gitsigns.reset_hunk(selected_range()) end, { desc = "Reset selection" })

vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff file" })
vim.keymap.set("n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>gB", gitsigns.toggle_current_line_blame, { desc = "Toggle inline blame" })
