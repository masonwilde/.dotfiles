-- LSP servers enabled via vim.lsp.enable (Neovim 0.11+).
-- Per-server overrides can live in after/lsp/<server>.lua.

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.enable({
	"clangd",
	"rust_analyzer",
	"pyright",
	"ruff",
	"lua_ls",
	"gopls",
	"ts_ls",
	"eslint",
	"html",
	"cssls",
	"jsonls",
	"tailwindcss",
})
