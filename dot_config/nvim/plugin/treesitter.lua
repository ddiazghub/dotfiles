require('core.pack').add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
}, {
  setup = function()
    vim.api.nvim_create_autocmd('PackChanged', {
      group = vim.api.nvim_create_augroup('user-pack-treesitter', { clear = true }),
      callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
          if not ev.data.active then
            vim.cmd.packadd 'nvim-treesitter'
          end
          vim.cmd 'TSUpdate'
        end
      end,
    })

    require('nvim-treesitter').setup {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    }
  end,
})
