{ config, pkgs, lib, ... }:

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
      sidebar-mode = true;
    };
  };

  home.sessionVariables.ROFI_PLUGIN_PATH = "${pkgs.rofi}/lib/rofi";
}

