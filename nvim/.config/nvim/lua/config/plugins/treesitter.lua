vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Neovim 0.12 starts treesitter highlighting on its own for any filetype with an
-- installed parser, and bundles only c, lua, markdown, query, vim and vimdoc.
-- Installing the rest is the only wiring still needed.
require("nvim-treesitter").install({
	"bash",
	"c",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"yaml",
})
