-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  lockfile = "~/.lazy-lockzz.json",
  checker = {
    enabled = true,     -- Enable automatic plugin update checks
    frequency = 604800, -- Check for updates every week (in seconds)
  },
  spec = {
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    { 'glacambre/firenvim', build = ":call firenvim#install(1)" , lazy = false},
    -- Core Neovim enhancements
    { 'tpope/vim-sleuth' },
    { 'nvim-treesitter/nvim-treesitter',            build = ':TSUpdate' },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nanotee/zoxide.vim" },
    { 'jvgrootveld/telescope-zoxide' },
    -- Language Support
    {
      "ray-x/go.nvim",
      dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
      config = function() require("go").setup() end,
      event = { "CmdlineEnter" },
      ft = { "go", 'gomod' },
      build = ':lua require("go.install").update_all_sync()'
    },

    -- LSP and Completion
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      dependencies = {
        { "neovim/nvim-lspconfig" },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'onsails/lspkind.nvim' } -- Icons for completion
      }
    },
    { 'stevearc/conform.nvim', opts = {} },                 -- Formatting
    { 'j-hui/fidget.nvim',     tag = 'legacy', opts = {} }, -- LSP progress UI

    -- Git and Version Control
    {
      'lewis6991/gitsigns.nvim',
      config = function() require('gitsigns').setup() end
    },
    { "tpope/vim-fugitive" },

    -- File Navigation and Search
    { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } },
    { 'mrjones2014/legendary.nvim',    requires = 'kkharji/sqlite.lua' },
    {
      "numToStr/Comment.nvim",
      config = function() require('Comment').setup() end
    },

    -- UI Enhancements
    { 'stevearc/dressing.nvim' },
    { 'akinsho/toggleterm.nvim',  version = "*",   config = true },
    { 'ellisonleao/gruvbox.nvim', name = 'gruvbox' },

    -- Code Navigation and Editing
    { "kylechui/nvim-surround",   version = "*",   event = "VeryLazy" },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      keys = {
        { "s",         mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<Leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
        { "S",         mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      }
    },

    -- Markdown and Documentation
    {
      "epwalsh/obsidian.nvim",
      lazy = false,
      ft = "markdown",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        workspaces = {
          { name = "personal", path = "~/vaults/personal" },
          { name = "work",     path = "~/vaults/work" }
        }
      }
    },

    -- Experimental AI Features
    {
      "olimorris/codecompanion.nvim",
      opts = {},
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      'yetone/avante.nvim',
      event = "VeryLazy",
      version = false,
      opts = {
        --   provider = "ollama",
        provider = "gemini",
        gemini = {
          model = "gemini-2.5-pro-exp-03-25",
        },
        cursor_applying_provider = 'gemini', -- In this example, use Groq for applying, but you can also use any provider you want.
        behaviour = {
          --- ... existing behaviours
          enable_cursor_planning_mode = true, -- enable cursor planning mode!
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "o4-mini",             -- your desired model (or use gemini-2.5-pro, etc.)
          timeout = 30000,               -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0,
          max_completion_tokens = 31000, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = "medium",   -- low|medium|high, only used for reasoning models
        },
        ollama = { model = "qwen3:8b" }
      },
      build = "make",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim"
      }
    },

    -- Additional Features
    { 'mrcjkb/rustaceanvim', version = '^5' },
    { 'theprimeagen/harpoon' },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
      }
    },
    {
      'MysticalDevil/inlay-hints.nvim',
      event = "LspAttach",
      dependencies = { "neovim/nvim-lspconfig" },
      config = function() require("inlay-hints").setup() end
    }
  },
})
