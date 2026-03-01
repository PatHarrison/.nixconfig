-- Main config entry point
require('config.options')
require('config.plugins.telescope')
require('config.plugins.lsp')
require('config.plugins.completion')
require('config.plugins.treesitter')
require('config.plugins.ui')
require('config.plugins.ollama')
require('config.keymaps')

-- Theme
vim.cmd([[colorscheme mistwood]])
