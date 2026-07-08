require('core.pack').add({
  'https://github.com/smjonas/inc-rename.nvim',
}, {
  setup = function()
    require('inc_rename').setup {}
  end,
})
