-- Servers are enabled only after the plugin pack has loaded (see `plugin/init.lua`),
-- otherwise `vim.lsp.config[...]` cannot be resolved from nvim-lspconfig's `lsp/`
-- directory and buffers opened during startup get no LSP client.
local servers = {
  -- Neovim and Lua
  'lua_ls',
  'stylua',

  -- TS/JS ecosystem
  'tsgo',
  'cssls',
  'superhtml',
  'biome',

  -- Python ecosystem
  'pyrefly',
  'ruff',

  -- Markup
  'yamlls',
  'jsonls',
  'superhtml',
  'cssls',
  'tombi',

  -- Docker
  'dockerls',

  -- GraphQL
  'graphql',

  -- Shell
  'bashls',
  'fish_lsp',

  -- C/C++
  'qmlls',

  -- Rust
  'rust_analyzer',

  -- Go
  'gopls',
}

---Enable all configured language servers.
---Must run after nvim-lspconfig is on the runtimepath, and it also attaches
---clients to buffers that were opened during startup.
local function enable()
  vim.lsp.enable(servers)
  -- Buffers opened on the command line fired `FileType` before the enable autocmd
  -- existed, so re-run it for all existing buffers (`:doautoall` is idempotent).
  vim.cmd.doautoall 'nvim.lsp.enable FileType'
end

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
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
  virtual_lines = {
    current_line = true,
  },
}

return {
  enable = enable,
}
