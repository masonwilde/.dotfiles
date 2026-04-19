vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP servers
		"clangd",
		"rust-analyzer",
		"pyright",
		"ruff",
		"lua-language-server",
		"gopls",
		"typescript-language-server",
		"eslint-lsp",
		"html-lsp",
		"css-lsp",
		"json-lsp",
		"tailwindcss-language-server",

		-- Formatters
		"stylua",
		"prettier",
	},
	auto_update = false,
	run_on_start = true,
	start_delay = 3000,
})
