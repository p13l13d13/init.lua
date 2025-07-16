-- Neovim settings configuration
-- This file contains all basic Neovim settings and options

-- Leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

-- Line numbers and cursor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showmode = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.confirm = true

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
vim.o.foldenable = true

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.stdpath('data') .. '/backup//'
vim.opt.directory = vim.fn.stdpath('data') .. '/swap//'

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- UI settings
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.mouse = 'a'
vim.opt.updatetime = 150

-- Spell checking (disabled by default; toggle with Legendary)
-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en' }

-- https://github.com/epwalsh/obsidian.nvim/issues/286
-- vim.opt_local.conceallevel = 2

vim.diagnostic.config {
  virtual_lines = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

require('configs.autocmds')
