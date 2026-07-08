require('core.pack').add({ 'https://github.com/lewis6991/gitsigns.nvim' }, {
  setup = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '▟', show_count = true },
        topdelete = { text = '▜', show_count = true },
        changedelete = { text = '┃', show_count = true },
        untracked = { text = '┆' },
      },
      current_line_blame = true,
      attach_to_untracked = true,
    }
  end,
})
