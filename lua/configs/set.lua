-- Neovim settings configuration
-- This file contains all basic Neovim settings and options

-- Leader key
vim.g.mapleader = ","

-- Line numbers and cursor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.isfname:append("@-@")

-- Text display
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 99
vim.wo.foldtext = ''

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = 'unnamedplus'

-- UI settings
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.mouse = 'a'
vim.opt.updatetime = 150

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en' }

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { only_current_line = true },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Spell toggle mapping
vim.keymap.set('n', '<leader>sc', function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell checking: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = "Toggle Spell Checking" })

vim.diagnostic.config({ virtual_lines = { current_line = true } })
