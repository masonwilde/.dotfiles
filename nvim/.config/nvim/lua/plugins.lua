return {
    {
      "olimorris/onedarkpro.nvim",
      priority = 1000, -- Ensure it loads first
    },
    {
      "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
      lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
      dependencies = {
        -- main one
        { "ms-jpq/coq_nvim", branch = "coq" },

        -- 9000+ Snippets
        { "ms-jpq/coq.artifacts", branch = "artifacts" },

        -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
        -- Need to **configure separately**
        { 'ms-jpq/coq.thirdparty', branch = "3p" },
        -- - shell repl
        -- - nvim lua api
        -- - scientific calculator
        -- - comment banner
        -- - etc
        { 'folke/neodev.nvim' },
      },
      init = function()
        vim.g.coq_settings = {
            auto_start = 'shut-up', -- if you want to start COQ at startup
            -- Your COQ settings here
        }
      end,
      config = function()
        -- Your LSP settings here
      end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
          local configs = require("nvim-treesitter.configs")

          configs.setup({
              ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true },  
            })
        end
    },
    "vijaymarupudi/nvim-fzf",
    "lewis6991/gitsigns.nvim",
    "nvim-lualine/lualine.nvim",
    "numToStr/Comment.nvim",
    "williamboman/mason.nvim",
    "nvim-tree/nvim-tree.lua",
}
