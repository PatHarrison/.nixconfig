require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require("telescope.actions").move_selection_next,
        ['<C-k>'] = require("telescope.actions").move_selection_previous,
        ['<C-[>'] = require("telescope.actions").close,
      },
      n = {
        ['<C-j>'] = require("telescope.actions").move_selection_next,
        ['<C-k>'] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})
pcall(require('telescope').load_extension, 'fzf')
