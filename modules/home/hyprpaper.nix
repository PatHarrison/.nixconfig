{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
      ];

      wallpaper = [
        "eDP-1,/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
        "HDMI-A-1,/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"
        ",/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg"  # fallback for any monitor
      ];
    };
  };
}
