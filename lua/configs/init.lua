-- Neovim configuration initialization
-- This file loads all configuration modules and sets up the environment

-- Helper function to safely require modules
local function safe_require(module)
  local status_ok, result = pcall(require, module)
  if not status_ok then
    vim.notify("Failed to load " .. module .. ": " .. tostring(result), vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Load configuration modules
local function load_configs()
  -- Load basic settings
  safe_require("configs.set")
  
  -- Load key mappings
  safe_require("configs.remap")
  
  -- Load plugins
  safe_require("configs.plugins")
end

-- Reload module helper
function R(name)
  local status_ok, _ = pcall(require("plenary.reload").reload_module, name)
  if not status_ok then
    vim.notify("Failed to reload " .. name, vim.log.levels.ERROR)
    return
  end
  return safe_require(name)
end

-- Setup gruvbox theme
local function setup_theme()
  local gruvbox = safe_require("gruvbox")
  if gruvbox then
    gruvbox.setup({
      undercurl = true,
      underline = true,
      bold = true,
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "soft",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd([[colorscheme gruvbox]])
  end
end

-- Setup auto-formatting for Rust files
local function setup_rust_formatting()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- Setup Neovide specific settings
local function setup_neovide()
  if vim.g.neovide then
    vim.o.guifont = "Hack:h13"
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
    vim.g.neovide_cursor_animation_length = 0.07
  end
end

-- Initialize configuration
load_configs()
setup_theme()
setup_rust_formatting()
setup_neovide()

require("oil").setup()
