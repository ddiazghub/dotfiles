require('core.pack').add({ 'https://github.com/folke/tokyonight.nvim' }, {
  setup = function()
    require('tokyonight').setup {
      transparent = true,
      styles = {
        comments = { italic = false },
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }

    vim.cmd.colorscheme 'tokyonight-night'
  end,
})
