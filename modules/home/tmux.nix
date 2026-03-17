{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.bash}/bin/bash";
    terminal = "tmux-256color";
    historyLimit = 10000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-a";

    extraConfig = ''
      # True color
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Mouse support
      set -g mouse on

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Split with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Status bar
      set -g status-position top
      set -g status-style "bg=#${colors.base01},fg=#${colors.base05}"
      set -g status-left "#[fg=#${colors.base0B},bold] #S "
      set -g status-right "#[fg=#${colors.base03}] %H:%M %d-%b "
      set -g status-left-length 30

      set -g window-status-format "#[fg=#${colors.base04}] #I:#W "
      set -g window-status-current-format "#[fg=#${colors.base05},bg=#${colors.base02},bold] #I:#W "

      set -g pane-border-style "fg=#${colors.base02}"
      set -g pane-active-border-style "fg=#${colors.base0D}"

      set -g message-style "bg=#${colors.base01},fg=#${colors.base0A}"
    '';
  };
}
