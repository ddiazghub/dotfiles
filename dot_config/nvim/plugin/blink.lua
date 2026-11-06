require('core.pack').add({
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
  { src = 'https://github.com/saghen/blink.pairs', version = vim.version.range '*' },
}, {
  setup = function()
    local cmp = require 'blink.cmp'
    local pairs = require 'blink.pairs'
    local cmpTask = cmp.build()
    local pairsTask = pairs.download()
    cmpTask:pwait(60000)
    pairsTask:pwait(120000)
    pairs.setup()

    cmp.setup {
      keymap = { preset = 'default' },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
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
    }
  end,
})
