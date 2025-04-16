vim.g.mapleader = ","

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


-- enable mouse mode
vim.o.mouse = 'a'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

-- Sync clipboard between the OS and Neovim.
vim.o.clipboard = 'unnamedplus'

vim.opt.smartindent = true

vim.opt.wrap = true

-- Case insensitive searching UNLESS /C or the search has capitals.
vim.o.ignorecase = true
vim.o.smartcase = true

-- undo history and disable swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Update times and timeouts.
vim.o.updatetime = 150

vim.o.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode

-- Spell checking everywhere
vim.opt.spell = true
vim.opt.spelllang = { 'en' }

vim.keymap.set('n', '<leader>sc', function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell checking: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = "Toggle Spell Checking" })

vim.diagnostic.config({
  virtual_text = true,
  -- I use <leader>dl to toggle it, so they are disabled by default, because they're making such a mess
  virtual_lines = { only_current_line = true }
})
