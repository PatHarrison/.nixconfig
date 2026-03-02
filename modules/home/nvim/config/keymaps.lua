local keymap = vim.keymap.set

-- File explorer
keymap('n', '<leader>t', ':NERDTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope
keymap('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Find files' })
keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers' })
keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help tags' })

-- LSP
keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Buffer navigation
keymap('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
keymap('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Clear search highlighting
keymap('n', '<Esc>', ':nohlsearch<CR>')

-- Avante
keymap('n', '<leader>aa', '<cmd>AvanteAsk<cr>', { desc = 'Avante Ask' })
keymap('v', '<leader>ae', '<cmd>AvanteEdit<cr>', { desc = 'Avante Edit selection' })
