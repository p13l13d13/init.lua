local builtin = require('telescope.builtin')
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)


require('legendary').setup({
  extensions = { lazy_nvim = true },
  keymaps = {
    {
      '<leader>a',
      { n = mark.add_file },
      description = 'harpoon: add file',
    },
    {
      '<C-e>',
      { n = ui.toggle_quick_menu },
      description = 'open Legendary searcher',
    },
    {
      '<leader>bf',
      { n = vim.lsp.buf.format },
      description = 'format current buffer',
    },

    -- Legendary
    {
      '<leader>ll',
      '<Cmd>Legendary<CR>',
      description = 'open Legendary searcher',
    },

    -- Telescope mappings
    {
      '<leader>fr',
      builtin.resume,
      description = 'telescope open last picker',
    },
    {
      '<leader>/',
      function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      description = 'fuzzy find in the current buffer',
    },
    {
      '<leader>ff',
      builtin.find_files,
      description = 'telescope find files',
    },
    {
      '<leader>fb',
      builtin.buffers,
      description = 'telescope buffers',
    },
    {
      '<leader>fg',
      builtin.live_grep,
      description = 'telescope live grep',
    },
    {
      '<leader>fh',
      builtin.help_tags,
      description = 'telescope help tags',
    },
    {
      '<leader>fc',
      builtin.commands,
      description = 'telescope commands',
    },
    {
      '<leader>fd',
      builtin.diagnostics,
      description = 'telescope diagnostics',
    },
    {
      '<leader>fs',
      builtin.spell_suggest,
      description = 'telescope spell suggest',
    },
    {
      '<leader>fz',
      require("telescope").extensions.zoxide.list,
      description = 'telescope zoxide list',
    },
    -- LSP mappings
    {
      'gd',
      { n = vim.lsp.buf.definitions },
      description = 'go to definitions'
    },
    {
      'gi',
      { n = vim.lsp.buf.implementation },
      description = 'go to implementation'
    },
    {
      'gT',
      { n = vim.lsp.buf.type_definition },
      description = 'go to type definition'
    },
    {
      'K',
      { n = vim.lsp.hover },
      description = 'show hover info'
    },
    {
      '<leader>vws',
      { n = vim.lsp.buf.workspace_symbol },
      description = 'show workspace symbols'
    },

    {
      '<leader>vd',
      { n = vim.diagnostic.open_float },
      description = 'open float diagnostic'
    },

    {
      '<leader>ca',
      { n = vim.lsp.buf.code_action },
      description = 'code action menu'
    },
    {
      '<leader>rr',
      { n = vim.lsp.buf.references },
      description = 'show references'
    },
    {
      '<leader>rn',
      { n = vim.lsp.buf.rename },
      description = 'rename symbol under cursor'
    },
    {
      '<leader>z',
      { n = '<Cmd>Neotree filesystem reveal left toggle=true<CR>' },
      description = 'open Neotree on the left'
    },
    -- Harpoon mappings
    {
      '<leader>ha',
      function() require("harpoon.mark").add_file() end,
      description = 'Harpoon add file'
    },
    {
      '<leader>hm',
      function() require("harpoon.ui").toggle_quick_menu() end,
      description = 'Harpoon quick menu'
    },
    {
      '<leader>h1',
      function() require("harpoon.ui").nav_file(1) end,
      description = 'Harpoon go to file 1'
    },
    {
      '<leader>h2',
      function() require("harpoon.ui").nav_file(2) end,
      description = 'Harpoon go to file 2'
    },
    {
      '<leader>h3',
      function() require("harpoon.ui").nav_file(3) end,
      description = 'Harpoon go to file 3'
    },
    {
      '<leader>h4',
      function() require("harpoon.ui").nav_file(4) end,
      description = 'Harpoon go to file 4'
    },

    -- Terminal mapping
    {
      '<leader>tt',
      '<Cmd>ToggleTerm<CR>',
      description = 'toggle terminal'
    },

    -- Window navigation
    {
      '<C-h>',
      '<C-w>h',
      description = 'move to left window',
      opts = { noremap = true }
    },
    {
      '<C-j>',
      '<C-w>j',
      description = 'move to below window',
      opts = { noremap = true }
    },
    {
      '<C-k>',
      '<C-w>k',
      description = 'move to above window',
      opts = { noremap = true }
    },
    {
      '<C-l>',
      '<C-w>l',
      description = 'move to right window',
      opts = { noremap = true }
    },

    -- Window resizing
    {
      '<C-Up>',
      '<Cmd>resize +2<CR>',
      description = 'increase window height',
      opts = { noremap = true }
    },
    {
      '<C-Down>',
      '<Cmd>resize -2<CR>',
      description = 'decrease window height',
      opts = { noremap = true }
    },
    {
      '<C-Left>',
      '<Cmd>vertical resize -2<CR>',
      description = 'decrease window width',
      opts = { noremap = true }
    },
    {
      '<C-Right>',
      '<Cmd>vertical resize +2<CR>',
      description = 'quit window'
    },

    -- Buffer navigation
    {
      '<leader>bn',
      '<Cmd>bnext<CR>',
      description = 'go to next buffer'
    },
    {
      '<leader>bp',
      '<Cmd>bprevious<CR>',
      description = 'go to previous buffer'
    },
    {
      '<leader>bc',
      '<Cmd>bd<CR>',
      description = 'close current buffer'
    },

    -- Toggle comment (Comment.nvim)
    {
      '<leader>w',
      '<Cmd>w<CR>',
      description = 'save file'
    },
    {
      '<leader>q',
      '<Cmd>q<CR>',
      description = 'quit window'
    },

    -- Toggle comment (Comment.nvim)
    {
      'gc',
      {
        n = function() require('Comment.api').toggle.linewise.current() end,
        v = "<Plug>(comment_toggle_linewise_visual)"
      },
      description = 'toggle comment'
    },

    -- Toggle relative line numbers
    {
      '<leader>rn',
      function()
        vim.o.relativenumber = not vim.o.relativenumber
      end,
      description = 'toggle relative line numbers'
    },

    -- TODO: Add more lsp mappings
  },
})
