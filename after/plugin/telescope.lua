local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
        preview = {
            treesitter = false
        },
    },
})

require('telekasten').setup({
  home = vim.fn.expand("~/docs/zettelkasten"), -- Put the name of your notes directory here
})
