-- Neovim initialization file
-- This file handles the basic initialization of the Neovim configurationinit.lua
-- It includes special handling for FireNvim and error checking

-- Check if running in FireNvim context
local is_firenvim = vim.g.started_by_firenvim == true

-- Initialize configuration based on context
if is_firenvim then
  -- FireNvim specific initialization
  -- This prevents loading unnecessary plugins and configurations
  -- when running in a browser context
  vim.opt.laststatus = 0  -- Hide status line in FireNvim
  vim.opt.showtabline = 0 -- Hide tab line in FireNvim
else
  -- Regular Neovim initialization
  local status_ok, configs = pcall(require, "configs")
  if not status_ok then
    vim.notify("Failed to load configs: " .. tostring(configs), vim.log.levels.ERROR)
    return
  end
end
