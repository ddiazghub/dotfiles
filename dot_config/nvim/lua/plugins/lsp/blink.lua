---@module 'lazy'
---@type LazySpec
return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    build = function()
      -- build the fuzzy matcher, wait up to 60 seconds
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():wait(60000)
    end,
    dependencies = {
      'saghen/blink.lib',
      'folke/lazydev.nvim',
      'rafamadriz/friendly-snippets',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = false } },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          snippets = {
            opts = {
              friendly_snippets = true,
              extended_filetypes = {
                markdown = { 'jekyll' },
                sh = { 'shelldoc' },
                php = { 'phpdoc' },
                cpp = { 'unreal' },
              },
            },
          },
        },
      },

      fuzzy = {
        implementation = 'rust',
        sorts = {
          'score',
          'sort_text',
          'label',
        },
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = true,
          direction_priority = { 's', 'n' },
        },
        trigger = {
          enabled = true,
          show_on_accept = true,
        },
      },

      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
    },
    --   opts = {
    --     completion = {
    --
    --       menu = {
    --         draw = {
    --           padding = { 0, 1 },
    --           treesitter = { 'lsp' },
    --           components = {
    --             kind_icon = {
    --               -- text = function(ctx)
    --               --   return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' '
    --               -- end,
    --               text = function(ctx)
    --                 -- default kind icon
    --                 local icon = ctx.kind_icon
    --                 -- if LSP source, check for color derived from documentation
    --                 if ctx.item.source_name == 'LSP' then
    --                   local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
    --                   if color_item and color_item.abbr ~= '' then
    --                     icon = color_item.abbr
    --                   end
    --                 end
    --                 return icon .. ctx.icon_gap
    --               end,
    --               highlight = function(ctx)
    --                 -- default highlight group
    --                 local highlight = 'BlinkCmpKind' .. ctx.kind
    --                 -- if LSP source, check for color derived from documentation
    --                 if ctx.item.source_name == 'LSP' then
    --                   local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
    --                   if color_item and color_item.abbr_hl_group then
    --                     highlight = color_item.abbr_hl_group
    --                   end
    --                 end
    --                 return highlight
    --               end,
    --             },
    --             label = {
    --               text = function(ctx)
    --                 return require('colorful-menu').blink_components_text(ctx)
    --               end,
    --               highlight = function(ctx)
    --                 return require('colorful-menu').blink_components_highlight(ctx)
    --               end,
    --             },
    --             source_name = {
    --               text = function(ctx)
    --                 return '[' .. ctx.source_name .. ']'
    --               end,
    --               highlight = function(ctx)
    --                 return require('colorful-menu').blink_components_highlight(ctx)
    --               end,
    --             },
    --           },
    --           columns = {
    --             {
    --               'label',
    --               'label_description',
    --               gap = 1,
    --             },
    --             { 'kind_icon', 'kind' },
    --             { 'source_name', gap = 1 },
    --           },
    --         },
    --       },
    --
    --       list = {
    --         selection = {
    --           preselect = true,
    --           auto_insert = false,
    --         },
    --       },
    --     },
    --
    --     -- Shows a signature help window while you type arguments for a function
    --     signature = {
    --       enabled = true,
    --       window = {
    --         show_documentation = true,
    --         direction_priority = { 's', 'n' },
    --       },
    --       trigger = {
    --         enabled = true,
    --         show_on_accept = true,
    --       },
    --     },
    --
    --     cmdline = {
    --       keymap = {
    --         preset = 'inherit',
    --         ['<Tab>'] = { 'select_next' },
    --         ['<S-Tab>'] = { 'select_prev' },
    --       },
    --       completion = {
    --         menu = {
    --           auto_show = true,
    --         },
    --         list = { selection = { auto_insert = true, preselect = false } },
    --       },
    --     },
    --   },
    -- },
    -- -- Autopairs
    -- {
    --   'saghen/blink.pairs',
    --   version = '*', -- (recommended) only required with prebuilt binaries
    --   build = 'cargo build --release',
    --
    --   --- @module 'blink.pairs'
    --   --- @type blink.pairs.Config
    --   opts = {
    --     mappings = {
    --       -- you can call require("blink.pairs.mappings").enable()
    --       -- and require("blink.pairs.mappings").disable()
    --       -- to enable/disable mappings at runtime
    --       enabled = true,
    --       cmdline = true,
    --       -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
    --       -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
    --       disabled_filetypes = {},
    --       -- see the defaults:
    --       -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L14
    --       pairs = {},
    --     },
    --     highlights = {
    --       enabled = true,
    --       -- requires require('vim._extui').enable({}), otherwise has no effect
    --       cmdline = true,
    --       groups = {
    --         'BlinkPairsOrange',
    --         'BlinkPairsPurple',
    --         'BlinkPairsBlue',
    --       },
    --       unmatched_group = 'BlinkPairsUnmatched',
    --
    --       -- highlights matching pairs under the cursor
    --       matchparen = {
    --         enabled = true,
    --         -- known issue where typing won't update matchparen highlight, disabled by default
    --         cmdline = false,
    --         -- also include pairs not on top of the cursor, but surrounding the cursor
    --         include_surrounding = false,
    --         group = 'BlinkPairsMatchParen',
    --         priority = 250,
    --       },
    --     },
    --     debug = false,
    --   },
  },
}
