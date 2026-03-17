-- modules/home/nvim/config/init.lua
require('options')
require('plugins.telescope')
require('plugins.lsp')
require('plugins.completion')
require('plugins.treesitter')
require('plugins.ui')
-- require('plugins.avante')
require('keymaps')

vim.cmd([[colorscheme mistwood]])
