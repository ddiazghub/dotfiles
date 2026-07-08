require('core.pack').add({
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/echasnovski/mini.base16',
  'https://github.com/nvim-lualine/lualine.nvim',
}, {
  setup = function()
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
})
