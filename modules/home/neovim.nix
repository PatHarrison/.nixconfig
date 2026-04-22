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

      vim-fugitive

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

      #dap
      nvim-dap
      nvim-dap-python

    ];
  };


  # Create the nvim config directory structure
  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/config/init.lua;
    "nvim/lua/options.lua".source = ./nvim/config/options.lua;
    "nvim/lua/keymaps.lua".source = ./nvim/config/keymaps.lua;
    "nvim/lua/plugins/telescope.lua".source = ./nvim/config/plugins/telescope.lua;
    "nvim/lua/plugins/lsp.lua".source = ./nvim/config/plugins/lsp.lua;
    "nvim/lua/plugins/completion.lua".source = ./nvim/config/plugins/completion.lua;
    "nvim/lua/plugins/treesitter.lua".source = ./nvim/config/plugins/treesitter.lua;
    "nvim/lua/plugins/ui.lua".source = ./nvim/config/plugins/ui.lua;
    "nvim/lua/plugins/dap.lua".source = ./nvim/config/plugins/dap.lua;
  };
}
    
