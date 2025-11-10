local formatters_by_ft = {
  lua = { 'stylua' },
  rust = { 'rustfmt' },
}

local js_filetypes = {
  'astro',
  'css',
  'graphql',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'svelte',
  'typescript',
  'typescript.tsx',
  'typescriptreact',
  'vue',
}

for _, ft in ipairs(js_filetypes) do
  formatters_by_ft[ft] = { 'biome', 'prettierd', stop_after_first = true }
end

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = formatters_by_ft,
  },
}
