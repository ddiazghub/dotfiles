---@module 'lazy'
---@type LazySpec
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  config = function()
    require('config.keymaps').smart_splits()
  end,
}
