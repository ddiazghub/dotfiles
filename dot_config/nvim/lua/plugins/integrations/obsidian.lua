---@module 'lazy'
---@type LazySpec
return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  cmd = 'Obsidian',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/Obsidian Vault/',
      },
    },

    -- see below for full list of options 👇
  },
}
