local formatters_by_ft = {
  lua = { 'stylua' },
  rust = { 'rustfmt' },
  fish = { 'fish_indent' },
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
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local exclude = {
        filetypes = { 'c', 'cpp' },
        projects = {
          '~/dev/annise',
        },
      }

      local is_excluded_ft = false
      local is_excluded_project = false

      -- Check for excluded filetypes
      for i, ft in ipairs(exclude.filetypes) do
        if vim.bo[bufnr].filetype == ft then
          is_excluded_ft = true
          break
        end
      end

      -- Check for excluded projects
      for i, project in ipairs(exclude.projects) do
        local path = project:gsub('~', vim.env.HOME):gsub('*', ''):gsub('//', '/')
        local name = vim.api.nvim_buf_get_name(bufnr)

        if vim.startswith(name, path) then
          is_excluded_project = true
          break
        end
      end

      if is_excluded_ft or is_excluded_project then
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
