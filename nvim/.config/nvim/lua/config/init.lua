require('config.options')
require('config.keymaps')
require('config.diagnostics')
require('config.autocmds')

for _, file in ipairs(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/config/plugins", "*.lua", false, true)) do
	require("config.plugins." .. vim.fn.fnamemodify(file, ":t:r"))
end

require('config.lsp')
