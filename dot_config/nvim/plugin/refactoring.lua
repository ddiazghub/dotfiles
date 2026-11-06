require('core.pack').add({
  -- `async.nvim` is only required for Neovim 0.12. If you are using Neovim 0.13, you don't need it
  'https://github.com/lewis6991/async.nvim',
  'https://github.com/theprimeagen/refactoring.nvim',
}, {
  setup = function()
    require('refactoring').setup()
    require('config.keymaps').refactoring()
  end,
})
