-- Key mappings configuration
-- This file contains all custom key mappings for Neovim

-- Set leader key (already set in set.lua)
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Better indentation
map("v", "<", "<gv", { desc = "Decrease indent" })
map("v", ">", ">gv", { desc = "Increase indent" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Quick save and quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all windows" })

-- Buffer navigation
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Terminal mappings
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Move left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Move down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Move up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Move right" })

-- Diagnostic keymaps
map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP keymaps
local lsp = vim.lsp.buf
map("n", "gd", lsp.definition, { desc = "Go to definition" })
map("n", "gr", lsp.references, { desc = "Show references" })
map("n", "gi", lsp.implementation, { desc = "Go to implementation" })
map("n", "K", lsp.hover, { desc = "Show documentation" })
map("n", "<leader>rn", lsp.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", lsp.code_action, { desc = "Code action" })
