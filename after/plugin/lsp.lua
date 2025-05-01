-- LSP and Completion configuration using nvim-lspconfig and nvim-cmp
local cmp = require('cmp')
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-cmp setup
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- Using vim.snippet for Neovim 0.10+
      -- Replace with your snippet engine's expand function if different
      -- Example for luasnip: require('luasnip').lsp_expand(args.body)
      -- Example for vsnip (if you still use it): vim.fn["vsnip#anonymous"](args.body)
      -- Ensure your snippet plugin (like friendly-snippets) is loaded if needed.
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    -- Optional: Add borders to completion and documentation windows
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4), -- Keep original scroll keys
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection: Accept currently selected item
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp', keyword_length = 1 }, -- Trigger LSP completion earlier
      { name = 'nvim_lua', keyword_length = 2 },
      { name = 'path' },
    },
    {
      { name = 'buffer', keyword_length = 3 }, -- Source for buffer words
    }),
})

-- Base LSP keymaps to apply to all servers on attach
local on_attach = function(client, bufnr)
  -- Use buffer-local mappings and direct function calls
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Keybindings based on the original configuration
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  -- Use vim.lsp.buf.format which handles async/sync formatting based on server capabilities.
  -- Apply to normal ('n') and visual ('v') modes.
  vim.keymap.set({ 'n', 'v' }, '<F3>', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

  -- Optional: Add common diagnostic mappings (uncomment if desired)
  -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- Show diagnostics inline
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Go to next diagnostic
  -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- Add diagnostics to location list

  -- Display diagnostic signs using `vim.diagnostic.config`
  -- Ensure your colorscheme supports these highlight groups
  vim.diagnostic.config({
    virtual_text = true, -- Disable virtual text diagnostics
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({ name = 'DiagnosticSignError', text = '' })
  sign({ name = 'DiagnosticSignWarn', text = '' })
  sign({ name = 'DiagnosticSignHint', text = '' })
  sign({ name = 'DiagnosticSignInfo', text = '' })
end

-- LSP Server configurations
-- List of servers to set up with default settings + common on_attach and capabilities
local servers = {
  'bashls',
  'clangd',
  'gopls',
  'nil_ls',
  'pyright',
  'ts_ls',
  -- Note: rust_analyzer was commented out in the original file and remains excluded.
  -- If you want to add it back, ensure rust-analyzer is installed and uncomment:
  -- 'rust_analyzer',
}

for _, server_name in ipairs(servers) do
  lspconfig[server_name].setup {
    on_attach = on_attach,       -- Apply common keymaps and settings
    capabilities = capabilities, -- Set capabilities provided by cmp-nvim-lsp
  }
end

-- Custom setup for eslint (linter/formatter)
lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    -- Apply base keymaps first
    on_attach(client, bufnr)
    -- Enable EslintFixAll command on save for this buffer
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
      desc = "Run EslintFixAll on save",
    })
  end,
  capabilities = capabilities,
}

-- Custom setup for lua_ls (specifically tailored for Neovim config development)
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' }, -- Use LuaJIT runtime
      diagnostics = {
        -- Get the language server to recognize Neovim runtime globals
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- Avoid warnings for plugins like plenary
      },
      -- Do not send telemetry data containing filename paths, etc.
      telemetry = { enable = false },
    },
  },
}

-- Example: Custom setup for rust_analyzer (if re-added)
-- lspconfig.rust_analyzer.setup {
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr) -- Apply base keymaps
--     -- Add rust-analyzer specific settings or keymaps here, e.g., inlay hints
--     -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--   end,
--   capabilities = capabilities,
--   settings = {
--     ['rust-analyzer'] = {
--       -- Add any specific rust-analyzer settings here
--       -- Example: enable clippy checks
--       -- check = { command = "clippy" },
--     }
--   }
-- }

-- Make sure diagnostics appear in the sign column
vim.opt.signcolumn = 'yes'
