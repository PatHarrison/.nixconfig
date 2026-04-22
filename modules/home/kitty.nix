{ lib, config, pkgs, ... }:
let
  colors = config.lib.stylix.colors; # Stylix-exposed Base16 palette
in
{
  programs.kitty = lib.mkDefault{
    enable = true;
    shellIntegration.enableBashIntegration = true;

    settings = {
      scrollback_lines = 10000;
      update_check_interval = 0;
      enable_audio_bell = "no";
      confirm_os_window_close = "0";
      open_url_with = "default";
      shell = "bash";
      kitty_mod = "ctrl+shift";
      term = "xterm-256color";
      disable_ligatures = "cursor";
      font_family = "JetBrainsMono Nerd Font";
      font_size = "13.0";
      bold_font = "JetBrainsMono Nerd Font Bold";
      italic_font = "JetBrainsMono Nerd Font Italic";

      background_opacity = "1";

      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index}: {title}";
      active_tab_foreground = "#${colors.base05}";
      active_tab_background = "#${colors.base02}";
      inactive_tab_foreground = "#${colors.base04}";
      inactive_tab_background = "#${colors.base01}";
      
      # Cursor
      cursor_shape = "beam";
      cursor_blink = "on";
      
      # Dark theme colors
      foreground = "#${colors.base05}";
      background = "#${colors.base01}";
      selection_foreground = "#${colors.base02}";
      selection_background = "#${colors.base05}";
      
      # Cursor colors
      cursor = "#${colors.base05}";
      cursor_text_color = "#${colors.base01}";
      
      # URL underline color
      url_color = "#${colors.base05}";
      
      # Black
      color0 = "#${colors.base00}";
      color8 = "#${colors.base01}";
      
      # Red
      color1 = "#${colors.base08}";
      color9 = "#${colors.base08}";
      
      # Green
      color2 = "#${colors.base0B}";
      color10 = "#${colors.base0B}";
      
      # Yellow
      color3 = "#${colors.base0A}";
      color11 = "#${colors.base0A}";
      
      # Blue
      color4 = "#${colors.base0D}";
      color12 = "#${colors.base0D}";
      
      # Magenta
      color5 = "#${colors.base0E}";
      color13 = "#${colors.base0E}";
      
      # Cyan
      color6 = "#${colors.base0C}";
      color14 = "#${colors.base0C}";
      
      # White
      color7 = "#${colors.base0F}";
      color15 = "#${colors.base0F}";
    };

    keybindings = {
      "ctrl+shift+n" = "new_tab";
      "ctrl+shift+x" = "close_tab";
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+h" = "show_scrollback";
    };
  };
}
