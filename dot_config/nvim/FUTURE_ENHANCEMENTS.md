# Neovim Config - Future Enhancements

Priority levels: 🔴 High | 🟡 Medium | 🟢 Low

---

## 🟢 Debug Capabilities

**Plugin**: `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui`

**Why**: Debug code directly in Neovim with breakpoints, step-through, and variable inspection.

**Installation**:
```lua
-- plugin/dap.lua
require('core.pack').add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
}, {
  setup = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'python',
        'js',
        'codelldb', -- Rust
        'delve',    -- Go
        'java',
      },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸', play = '▶', step_into = '⏎',
          step_over = '⏭', step_out = '⏮', step_back = 'b',
          run_last = '▶▶', terminate = '⏹', disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
})
```

**Keymaps to add**:
```lua
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: Toggle UI' })
```

---

## 🟢 Git Conflict Resolution

**Plugin**: `akinsho/git-conflict.nvim`

**Why**: Navigate and resolve merge conflicts with keybindings.

**Installation**:
```lua
-- plugin/git-conflict.lua
require('core.pack').add({ 'https://github.com/akinsho/git-conflict.nvim' }, {
  setup = function()
    require('git-conflict').setup {
      default_mappings = {
        ours = 'co',
        theirs = 'ct',
        none = 'c0',
        both = 'cb',
        next = ']x',
        prev = '[x',
      },
    }
  end,
})
```

---

## 🟢 Multiple Cursors

**Plugin**: `smoka7/multicursors.nvim`

**Why**: VSCode-style multicursor editing for bulk changes.

**Installation**:
```lua
-- plugin/multicursors.lua
require('core.pack').add({
  'https://github.com/smoka7/multicursors.nvim',
  'https://github.com/stevearc/resession.nvim',
}, {
  setup = function()
    require('multicursors').setup()
  end,
})
```

**Keymaps**:
```lua
vim.keymap.set({ 'n', 'v' }, '<C-m>', function() require('multicursors').toggle() end, { desc = 'Multicursor: Toggle' })
vim.keymap.set('n', '<C-n>', function() require('multicursors').add_cursor_down() end, { desc = 'Multicursor: Add Down' })
vim.keymap.set('n', '<C-p>', function() require('multicursors').add_cursor_up() end, { desc = 'Multicursor: Add Up' })
```

---

## 🟢 Test Runner (Neotest)

**Plugin**: `nvim-neotest/neotest` + adapters

**Why**: Run tests directly in Neovim with inline results.

**Installation**:
```lua
-- plugin/neotest.lua
require('core.pack').add({
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-plenary',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/nvim-neotest/neotest-vim-test',
}, {
  setup = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-plenary',
        require 'neotest-jest',
        require 'neotest-python',
      },
    }
  end,
})
```

**Keymaps**:
```lua
vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end, { desc = 'Test: Run Nearest' })
vim.keymap.set('n', '<leader>tT', function() require('neotest').run.run(vim.fn.expand '%') end, { desc = 'Test: Run File' })
vim.keymap.set('n', '<leader>ts', function() require('neotest').run.stop() end, { desc = 'Test: Stop' })
vim.keymap.set('n', '<leader>to', function() require('neotest').output.open() end, { desc = 'Test: Output' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run { strategy = 'dap' } end, { desc = 'Test: Debug' })
```

---

## 🟢 Org Mode Files

**Plugin**: `nvim-orgmode/orgmode`

**Why**: Edit Org files with folding, agendas, and TODO management.

**Installation**:
```lua
-- plugin/orgmode.lua
require('core.pack').add({ 'https://github.com/nvim-orgmode/orgmode' }, {
  setup = function()
    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/default.org',
    }
  end,
})
```

---

## 🟡 Other Considerations

### Code Outline
**Plugin**: `hedyhli/outline.nvim`
- Symbol tree sidebar for navigating code structure

### Jump List Enhancement
**Plugin**: `ThePrimeagen/harpoon2`
- Alternative to arrow.nvim (simpler, faster)
- Only add if Arrow feels slow or bloated

### Better Search/Replace
**Plugin**: `roobert/search-replace.nvim`
- Interactive search and replace across files

---

## Notes

- **Don't add plugins preemptively** - only when workflow demands it
- **Test each plugin individually** before adding to main config
- **Keep keymap conventions consistent** with existing patterns
- **Check for plugin conflicts** especially with snacks.nvim features

---

### Vim be good:

```lua
-- Save path: /home/neoddiaz/.config/nvim/lua/plugins/vim-be-good.lua
-- Edit the config below, then :w to save.
-- Change the path above to write elsewhere.

vim.pack.add({"https://github.com/ThePrimeagen/vim-be-good"})
```
> [!IMPORTANT]
> ADD BLINK.pairs
> ROCKS.nvim
> REST.nvim https://github.com/rest-nvim/rest.nvim
> https://github.com/catgoose/nvim-colorizer.lua
> NEOGIT.nvim
> BLINK INDENT

Last updated: 2026-05-05
