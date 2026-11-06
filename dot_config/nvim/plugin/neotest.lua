require('core.pack').add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/fredrikaverpil/neotest-golang',
  'https://github.com/nvim-neotest/neotest',
}, {
  setup = function()
    local config = {
      runner = 'gotestsum', -- Optional, but recommended
    }

    require('neotest').setup {
      adapters = {
        require 'neotest-golang'(config),
      },
    }
  end,
})
