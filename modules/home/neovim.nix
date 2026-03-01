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

      (pkgs.vimUtils.buildVimPlugin {
        name = "ollama.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "nomnivore";
          repo = "ollama.nvim";
          rev = "main";
          sha256 = "sha256-8tW5tp2GiYw+PnR7rqiKfykLW/yqvGOtqauZCgEeQCg=";
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
    ];
  };


  # Create the nvim config directory structure
  xdg.configFile = {
	"nvim/config/init.lua".source = ./nvim/config/init.lua;
	"nvim/config/options.lua".source = ./nvim/config/options.lua;
	"nvim/config/keymaps.lua".source = ./nvim/config/keymaps.lua;
	"nvim/config/plugins/telescope.lua".source = ./nvim/config/plugins/telescope.lua;
	"nvim/config/plugins/lsp.lua".source = ./nvim/config/plugins/lsp.lua;
	"nvim/config/plugins/completion.lua".source = ./nvim/config/plugins/completion.lua;
	"nvim/config/plugins/treesitter.lua".source = ./nvim/config/plugins/treesitter.lua;
	"nvim/config/plugins/ui.lua".source = ./nvim/config/plugins/ui.lua;
	"nvim/config/plugins/ollama.lua".source = ./nvim/config/plugins/ollama.lua;
  };
}
    
