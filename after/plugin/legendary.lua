local builtin = require('telescope.builtin')

require('legendary').setup({
  extensions = { lazy_nvim = true },
  keymaps = {
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
          { n =  '<Cmd>NvimTreeToggle<CR>'},
          description = 'rename symbol under cursor'
        },
        
        -- TODO: Add harpoon mappings  
        -- TODO: Add more lsp mappings
        -- TODO: Add terminal mapping
        -- TODO: Add windows-movements mappings
    },
})
