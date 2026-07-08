require('core.pack').add({ 'https://github.com/folke/lazydev.nvim' }, {
  event = 'FileType',
  pattern = 'lua',
  setup = function()
    require('lazydev').setup {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    }
  end,
})
