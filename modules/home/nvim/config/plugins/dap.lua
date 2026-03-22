require('dap-python').setup('python')
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'DAP continue' })
vim.keymap.set('n', '<leader>ds', require('dap').step_over, { desc = 'DAP step over' })
