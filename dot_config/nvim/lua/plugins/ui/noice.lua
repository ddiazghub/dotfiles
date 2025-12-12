---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      messages = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = false },
        inc_rename = { enabled = true },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
}
