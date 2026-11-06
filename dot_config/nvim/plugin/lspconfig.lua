require('core.pack').add({
  'https://github.com/neovim/nvim-lspconfig',
}, {
  setup = function()
    require('core.lsp').enable()
  end,
})
