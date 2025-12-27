---@module 'lazy'
---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-mini/mini.icons', 'echasnovski/mini.base16' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
      },
    }
  end,
}
