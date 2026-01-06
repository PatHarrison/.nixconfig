{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swaybg ];
  # home.packages = [ pkgs.hyprpaper ];
  #
  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     preload = [
  #       "home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
  #     ];
  #
  #     wallpaper = [
  #       "eDP-1,/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
  #       "HDMI-A-1,/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
  #       ",/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
  #     ];
  #
  #     splash = false;
  #   };
  # };
}
