local conform = require('conform') -- For formatting
local fidget = require('fidget')   -- For LSP progress notifications

-- Setup fidget for LSP progress display
fidget.setup({})

-- Basic setup for conform (needs further configuration with formatters)
conform.setup({
  -- Define formatters by filetype
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    javascript = { { "prettierd", "eslint_d" }, "prettier" },
    typescript = { { "prettierd", "eslint_d" }, "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    rust = { "rustfmt" },
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- Make sure diagnostics appear in the sign column
vim.opt.signcolumn = 'yes'
