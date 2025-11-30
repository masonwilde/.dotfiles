return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"clangd",        -- C/C++
			"rust_analyzer", -- Rust
			"pyright",       -- Python
			"ruff",          -- Python linter/formatter
			"lua_ls",        -- Lua
			"gopls",         -- Go
			"ts_ls",         -- TypeScript/JavaScript
			"eslint",        -- JavaScript/TypeScript linter
			"html",          -- HTML
			"cssls",         -- CSS
			"jsonls",        -- JSON
			"tailwindcss",   -- TailwindCSS
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		-- Setup with handlers inline
		mason_lspconfig.setup(vim.tbl_extend("force", opts, {
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({})
				end,
			},
		}))

		-- Diagnostic keymaps
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer-local keymaps
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
	end,
}
