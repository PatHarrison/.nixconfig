{ config, pkgs, ... }:
let
  C = config.lib.stylix.colors;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "/home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg";
      scaling = "fill";
      effect-blur = "8x4";
      effect-vignette = "0.1:0.8";
      clock = true; timestr = "%H:%M"; datestr = "%A, %B %d";
      indicator = true; indicator-radius = 90; indicator-thickness = 8;
      indicator-idle-visible = false;

      inside-color          = "${C.base00}cc";
      inside-clear-color    = "${C.base00}cc";
      inside-ver-color      = "${C.base0D}44";
      inside-wrong-color    = "${C.base08}44";
      ring-color            = "${C.base02}";
      ring-clear-color      = "${C.base0B}";
      ring-ver-color        = "${C.base0D}";
      ring-wrong-color      = "${C.base08}";
      line-color        = "00000000";
      line-clear-color  = "00000000";
      line-ver-color    = "00000000";
      line-wrong-color  = "00000000";
      key-hl-color          = "${C.base0B}";
      bs-hl-color           = "${C.base08}";
      caps-lock-key-hl-color = "${C.base0A}";
      caps-lock-bs-hl-color  = "${C.base09}";
      text-color            = "${C.base05}";
      text-clear-color      = "${C.base0B}";
      text-ver-color        = "${C.base0D}";
      text-wrong-color      = "${C.base08}";
      separator-color       = "00000000";
      font = "JetBrains Nerd Font"; font-size = 20;
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof swaylock || swaylock -f";
        before_sleep_cmd = "loginctl lock-session && sleep 1";
        after_sleep_cmd = "hyprctl dispatch dpms off && sleep 1 && hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [
        { timeout = 150; on-timeout = "brightnessctl -s set 10%"; on-resume = "brightnessctl -r"; }
        { timeout = 300; on-timeout = "loginctl lock-session"; }
        { timeout = 600; on-timeout = "systemctl suspend"; }
      ];
    };
  };
}
