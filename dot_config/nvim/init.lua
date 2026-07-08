-- Neovim entry point: bootstraps config, LSP, UI, and plugin pack manager.
require 'config'
require 'core.lsp'
require 'core.ui'
require('core.pack').configure()
