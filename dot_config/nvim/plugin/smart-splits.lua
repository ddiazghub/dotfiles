require('core.pack').add({ 'https://github.com/mrjones2014/smart-splits.nvim' }, {
  setup = function()
    require('config.keymaps').smart_splits()
  end,
})
