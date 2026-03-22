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

      # Windows (tabs)
      bind t new-window -c "#{pane_current_path}"
      bind w kill-window
      bind , command-prompt -I "#W" "rename-window '%%'"

      # Quick jump to window by number
      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5

      # Prefix + vim keys to switch panes
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Prefix + vim keys to resize panes (-r means repeatable)
      bind -r C-h resizepane -L 5
      bind -r C-j resize-pane -D 5
      bind -r C-k resize-pane -U 5
      bind -r C-l resize-pane -R 5

      # Split with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Move windows left/right
      bind -r < swap-window -d -t -1
      bind -r > swap-window -d -t +1

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Copy mode vim bindings
      bind v copy-mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle

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

      set -g message-style "bg=#${colors.base02},fg=#${colors.base0A}"
    '';
  };
}
