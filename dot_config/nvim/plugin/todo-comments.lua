require('core.pack').add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/folke/todo-comments.nvim',
}, {
  event = 'VimEnter',
  setup = function()
    require('todo-comments').setup { signs = false }
  end,
})
