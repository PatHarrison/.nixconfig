{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # Color scheme
      (pkgs.vimUtils.buildVimPlugin {
        name = "mistwood";
        src = pkgs.fetchFromGitHub {
          owner = "PatHarrison";
          repo = "mistwood.nvim";
          rev = "master";
          sha256 = "sha256-qJuzqtqWIYRxR7Qg+BR3KBo0Z6p3EK6Misw8fe8jWXI=";
        };
      })

      vimtex

      # File explorer
      nerdtree
      nerdtree-git-plugin
      nvim-web-devicons
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      
      # LSP Support
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      
      # Syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.python
        p.javascript
        p.typescript
        p.rust
        p.go
        p.bash
        p.json
        p.yaml
        p.markdown
      ]))
      
      # Git integration
      gitsigns-nvim
      
      # Status line
      lualine-nvim
      
      # Autopairs
      nvim-autopairs
      
      # Comment toggle
      comment-nvim
      
      # Indent guides
      # indent-blankline-nvim
    ];
    
    extraLuaConfig = ''
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

      
      -- Theme
      vim.cmd([[colorscheme mistwood]])
      vim.o.background = 'dark'
      
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
      
      -- Telescope setup
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
      
      -- Treesitter setup
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
      
      -- LSP setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = { 'nil_ls', 'pyright', 'rust_analyzer', 'ts_ls' }
      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp, {
          capabilities = capabilities,
        })
      end
      
      -- Completion setup
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
      
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
      
      -- Key mappings
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
    '';
    
    extraPackages = with pkgs; [
      # Language servers
      nil              # Nix
      pyright          # Python
      rust-analyzer    # Rust
      nodePackages.typescript-language-server  # TypeScript/JavaScript
      lua-language-server

      # Additional tools
      ripgrep          # For telescope grep
      fd               # For telescope find
      tree-sitter
    ];
  };
}
