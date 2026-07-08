require('core.pack').add({
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/echasnovski/mini.base16',
}, {
  setup = function()
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
  end,
})
