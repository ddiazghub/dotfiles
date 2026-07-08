require('core.pack').add({ 'https://github.com/alex-popov-tech/store.nvim' }, {
  cmd = 'Store',
  setup = function()
    require('store').setup {}
  end,
})
