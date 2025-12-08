{ config, pkgs, ... }:

let
  C = config.lib.stylix.colors;
in
{
  services.dunst = {
    enable = true;

    # settings = {
    #   global = {
    #     frame_color = "#${C.base01}";
    #     separator_color = "frame";
    #     background = "#${C.base00}";
    #     foreground = "#${C.base06}";
    #   };
    #
    #   urgency_low = {
    #     background = "#${C.base00}";
    #     foreground = "#${C.base05}";
    #     frame_color = "#${C.base02}";
    #   };
    #
    #   urgency_normal = {
    #     background = "#${C.base00}";
    #     foreground = "#${C.base06}";
    #     frame_color = "#${C.base0D}";
    #   };
    #
    #   urgency_critical = {
    #     background = "#${C.base08}";
    #     foreground = "#${C.base07}";
    #     frame_color = "#${C.base09}";
    #   };
    # };
  };
}
