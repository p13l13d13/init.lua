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
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    },
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    },
    -- nvim in firefox. I'm not really using this right now, but wanted to keep it.
    { 'glacambre/firenvim', build = ":call firenvim#install(0)" },
    -- Copilot AI.
    { "github/copilot.vim" },
    -- Telekasten is for notes taking
    {
      'renerocksai/telekasten.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    "jvgrootveld/telescope-zoxide",
    -- Some improvements to neovim UI. Like LSP renaming, etc.
    { 'stevearc/dressing.nvim' },
    -- Cool features for rust.
    {
      'mrcjkb/rustaceanvim',
      version = '^5', -- Recommended
      lazy = false,   -- This plugin is already lazy
    },
    'nvim-tree/nvim-web-devicons',
    -- Keymap but in telescope
    {
      'mrjones2014/legendary.nvim',
      -- sqlite is only needed if you want to  frequency sorting
      requires = 'kkharji/sqlite.lua'
    },
    -- Debugging
    'mfussenegger/nvim-dap',
    {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Better terminals, could be toggled + better positions
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
    -- It's like the best 'minimal' git plugins for nvim. Look at the green lines on the left!
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    },
    -- My favourite theme! Just the best!
    {
      'ellisonleao/gruvbox.nvim',
      name = 'gruvbox',
    },
    -- Functions' arguments, etc.
    { "ray-x/lsp_signature.nvim" },
    -- binds for commenting blocks
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    },
    -- Why is it still a plugin???
    { 'nvim-treesitter/nvim-treesitter',            build = ':TSUpdate' },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- Quick jumps between jump points
    'theprimeagen/harpoon',
    -- super quick jumps by S, f, F, t, T AAAAND treesitter
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      -- stylua: ignore
      keys = {
        { "s",         mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<Leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
        { "S",         mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      },
    },
    -- {
    --   'phaazon/hop.nvim',
    --   branch = 'v2', -- optional but strongly recommended
    --   config = function()
    --     require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    --   end,
    --   name = 'hop'
    -- },
    { "tpope/vim-fugitive" },
    -- Plugin to edit obsidian notes in nvim.
    {
      "epwalsh/obsidian.nvim",
      lazy = false,
      ft = "markdown",
      dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "personal",
            path = "~/vaults/personal",
          },
          {
            name = "work",
            path = "~/vaults/work",
          },
        },
      },
    },
    {
      "MysticalDevil/inlay-hints.nvim",
      event = "LspAttach",
      dependencies = { "neovim/nvim-lspconfig" },
      config = function()
        require("inlay-hints").setup()
      end
    },
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      dependencies = {
        { "neovim/nvim-lspconfig" },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
      }
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      }
    }
  },
})
