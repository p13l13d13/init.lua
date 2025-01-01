if vim.g.started_by_firenvim == true then
  -- Don't init anything. But would that work in all cases?
else
  require("configs")
end
