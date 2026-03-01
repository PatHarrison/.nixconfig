-- Gitsigns setup
require('gitsigns').setup()

-- Lualine setup
require('lualine').setup({
  options = {
    theme = 'gruvbox',
  },
})

-- Autopairs setup
require('nvim-autopairs').setup()

-- Comment setup
require('Comment').setup()
