{ config, pkgs, lib, ... }:
let
  C = config.lib.stylix.colors;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    extraConfig = {
      modi = "drun,run,window";
      show-icons = false;
      terminal = "kitty";
      drun-display-format = "{name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "  Apps";
      display-run = "  Run";
      display-window = "  Windows";
      sidebar-mode = true;
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "*" = {
        bg        = mkLiteral "#${C.base00}AA";
        bg-alt    = mkLiteral "#${C.base01}AA";
        fg        = mkLiteral "#${C.base05}";
        fg-dim    = mkLiteral "#${C.base03}";
        accent    = mkLiteral "#${C.base0B}";
        urgent    = mkLiteral "#${C.base08}";
        border-color = mkLiteral "#${C.base02}";
        background-color = mkLiteral "transparent";
        font      = "JetBrains Nerd Font 12";
      };
      "window" = {
        background-color = mkLiteral "@bg";
        border           = mkLiteral "1px";
        border-color     = mkLiteral "@border-color";
        border-radius    = mkLiteral "2px";
        width            = mkLiteral "720px";
        padding          = mkLiteral "0";
      };
      "mainbox" = {
        background-color = mkLiteral "transparent";
        children         = mkLiteral "[inputbar, listview]";
        spacing          = mkLiteral "0";
      };
      "inputbar" = {
        background-color = mkLiteral "@bg-alt";
        border-radius    = mkLiteral "4px 4px 0 0";
        padding          = mkLiteral "7px 10px";
        spacing          = mkLiteral "2px";
        children         = mkLiteral "[prompt, entry]";
      };
      "prompt" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "@accent";
        font             = "JetBrains Nerd Font 12";
      };
      "entry" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "@fg";
        placeholder-color = mkLiteral "@fg-dim";
        placeholder      = "search...";
      };
      "listview" = {
        background-color = mkLiteral "transparent";
        padding          = mkLiteral "3px";
        spacing          = mkLiteral "2px";
        lines            = 8;
        fixed-height     = true;
      };
      "element" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "@fg-dim";
        border-radius    = mkLiteral "2px";
        padding          = mkLiteral "4px 5px";
      };
      "element selected" = {
        background-color = mkLiteral "@bg-alt";
        text-color       = mkLiteral "@fg";
        border           = mkLiteral "0 0 0 2px";
        border-color     = mkLiteral "@accent";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "inherit";
        highlight        = mkLiteral "bold #${C.base0A}";
      };
      "scrollbar" = {
        background-color = mkLiteral "@bg-alt";
        handle-color     = mkLiteral "@border-color";
        handle-width     = mkLiteral "4px";
        border-radius    = mkLiteral "4px";
        width            = mkLiteral "4px";
      };
      "mode-switcher" = {
        background-color = mkLiteral "@bg-alt";
        border-radius    = mkLiteral "0 0 2px 2px";
        padding          = mkLiteral "4px";
        spacing          = mkLiteral "2px";
      };
      "button" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "@fg-dim";
        border-radius    = mkLiteral "2px";
        padding          = mkLiteral "4px 10px";
      };
      "button selected" = {
        background-color = mkLiteral "@bg";
        text-color       = mkLiteral "@accent";
      };
    };
  };
  home.sessionVariables.ROFI_PLUGIN_PATH = "${pkgs.rofi}/lib/rofi";
}
