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

local function lsp_on_attach(client, bufnr)
  -- Use this function for buffer-local customizations (e.g., formatting on save, inlay hints, etc.)
  -- Keymaps are managed by Legendary and should not be duplicated here.
end

require("lazy").setup({
  lockfile = "~/.lazy-lockzz.json",
  checker = {
    enabled = true,     -- Enable automatic plugin update checks
    frequency = 604800, -- Check for updates every week (in seconds)
  },
  spec = {
    { 'kevinhwang91/nvim-ufo',                      dependencies = 'kevinhwang91/promise-async' },
    "karb94/neoscroll.nvim",
    {
      'szymonwilczek/vim-be-better',
      config = function()
        -- Optional: Enable logging for debugging
        vim.g.vim_be_better_log_file = 1
      end
    },
    {
      'saghen/blink.cmp',
      version = '1.*',
      opts = {
        keymap = { preset = 'default', ["<Return>"] = { 'accept', 'fallback' } },
        signature = { enabled = true },
        completion = {
          -- By default, you may press `<c-space>` to show the documentation.
          -- Optionally, set `auto_show = true` to show the documentation after a delay.
          documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets' },
        }
      }
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = { 'saghen/blink.cmp' },

      opts = {
        servers = {
          lua_ls = {},
          basedpyright = {},
          ruff = {},
          bashls = {},
          clangd = {},
          dockerls = {},
          fish_lsp = {},
          zls = {}
        },
      },
      config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          config.on_attach = lsp_on_attach
          lspconfig[server].setup(config)
        end
      end
    },
    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    { 'glacambre/firenvim',                         build = ":call firenvim#install(1)",        lazy = false },
    -- Core Neovim enhancements
    { 'tpope/vim-sleuth' },
    { 'nvim-treesitter/nvim-treesitter',            build = ':TSUpdate' },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { 'nanotee/zoxide.vim' },
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
    { 'stevearc/conform.nvim' },                           -- Formatting
    { 'j-hui/fidget.nvim',    tag = 'legacy', opts = {} }, -- LSP progress UI

    -- Git and Version Control
    {
      'lewis6991/gitsigns.nvim',
      config = function() require('gitsigns').setup() end
    },
    { "tpope/vim-fugitive" },

    -- File Navigation and Search
    {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      dependencies = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'jvgrootveld/telescope-zoxide' },
      },
      config = function()
        require('telescope').setup({
          defaults = {
            mappings = {
              i = {
                ["<esc>"] = require("telescope.actions").close,
              },
            },
            preview = { treesitter = false },
          },
        })
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        pcall(require('telescope').load_extension, 'zoxide')
      end
    },
    { 'mrjones2014/legendary.nvim', requires = 'kkharji/sqlite.lua' },
    {
      "numToStr/Comment.nvim",
      config = function() require('Comment').setup() end
    },

    -- UI Enhancements
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    { 'stevearc/dressing.nvim' },
    { 'akinsho/toggleterm.nvim',  version = "*",      config = true },
    { 'ellisonleao/gruvbox.nvim', name = 'gruvbox' },
    { 'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            theme = 'auto',
            icons_enabled = true,
            section_separators = '',
            component_separators = '',
            globalstatus = true,
          },
        }
      end
    },

    -- Code Navigation and Editing
    { "kylechui/nvim-surround",   version = "*",      event = "VeryLazy" },
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
        provider = "openai",
        cursor_applying_provider = 'openai', -- In this example, use Groq for applying, but you can also use any provider you want.
        behaviour = {
          --- ... existing behaviours
          enable_cursor_planning_mode = true, -- enable cursor planning mode!
        },
        providers = {
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4.1", -- your desired model (or use gemini-2.5-pro, etc.)
          },
          ollama = { model = "qwen3:8b" },
        },
        hints = { enabled = false }
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
      'MysticalDevil/inlay-hints.nvim',
      event = "LspAttach",
      dependencies = { "neovim/nvim-lspconfig" },
      config = function() require("inlay-hints").setup() end
    },
    { 'rmagatti/auto-session',
      config = function()
        require('auto-session').setup {
          log_level = 'error',
          auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
        }
      end
    },
    { 'lewis6991/impatient.nvim',
      config = function()
        pcall(require, 'impatient')
      end
    },
  },
})
