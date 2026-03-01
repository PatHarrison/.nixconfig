-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamedplus'

-- VimTeX basic configs
vim.cmd("let g:vimtex_view_method = 'zathura'")
vim.g.vimtex_compiler_latexmk = {
  backend = 'nvim',
  options = {
    '-pdf',
    '-interaction=nonstopmode',
    '-synctex=1',
    '-shell-escape',
    '-output-directory=output',
    '-aux-directory=output',
  }
}

-- NERDTree setup
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
