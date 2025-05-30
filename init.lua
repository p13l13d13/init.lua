require("configs")

if vim.g.started_by_firenvim == true then
  vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
  }
  vim.o.laststatus = 0
else
  vim.o.laststatus = 2
end
