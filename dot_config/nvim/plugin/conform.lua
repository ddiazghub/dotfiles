local formatters_by_ft = {
  go = { 'gofmt' },
  lua = { 'stylua' },
  rust = { 'rustfmt' },
  fish = { 'fish_indent' },
  python = { 'ruff' },
}

for _, ft in ipairs {
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
} do
  formatters_by_ft[ft] = { 'biome', 'prettierd', stop_after_first = true }
end

require('core.pack').add({ 'https://github.com/stevearc/conform.nvim' }, {
  setup = function()
    require('conform').setup {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local exclude = {
          filetypes = { 'c', 'cpp' },
          projects = { '~/dev/annise' },
        }

        for _, ft in ipairs(exclude.filetypes) do
          if vim.bo[bufnr].filetype == ft then
            return nil
          end
        end

        for _, project in ipairs(exclude.projects) do
          local path = project:gsub('~', vim.env.HOME):gsub('*', ''):gsub('//', '/')
          if vim.startswith(vim.api.nvim_buf_get_name(bufnr), path) then
            return nil
          end
        end

        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = formatters_by_ft,
    }
  end,
})
