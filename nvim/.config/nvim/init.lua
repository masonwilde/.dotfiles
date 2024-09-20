function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ","

-- Keymaps for Nvim tree
Map('n', '<leader>e', ':NvimTreeToggle<cr>')
Map('n', '<C-Left>', '<C-w><Left>')
Map('n', '<C-Right>', '<C-w><Right>')

Map('n', '<leader>ff', vim.lsp.buf.format, {})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"
vim.opt.cursorline = true

-- use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Display settings
vim.opt.termguicolors = true

-- Title
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to

-- Persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- Tab stuff
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.softtabstop = -1

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- Highlight trailing characters
vim.opt.listchars = {
    -- eol = "↲",
    tab = "▸ ",
    trail = "·",
}
vim.opt.list = true

-- Return to previous location in file.
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"", false)
        end
    end
})

-- nvim-tree
vim.keymap.set("n", "<C-t>", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-c>", ":NvimTreeClose<CR>")

-- Moving between splits and resizing
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-w>k", ":resize +15<CR>")
vim.keymap.set("n", "<C-w>j", ":resize -15<CR>")
vim.keymap.set("n", "<C-w>h", ":vertical:resize -15<CR>")
vim.keymap.set("n", "<C-w>l", ":vertical:resize +15<CR>")

require("config.lazy")

require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}
require 'lspconfig'.pyright.setup {}
require 'lspconfig'.rls.setup {}
require 'lspconfig'.clangd.setup {}
require 'lspconfig'.cmake.setup {}
require 'lspconfig'.svelte.setup {}

require("mason").setup()
require('Comment').setup()

require('lualine').setup {
    options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {
            '%=', --[[ add your center compoentnts here in placenvim-tree/nvim-tree.lua of this comment ]]
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
}

require("nvim-tree").setup()
