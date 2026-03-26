{ pkgs, ... }:

{
  systemd.user.services.hyprland-unlock = {
    Unit = {
      Description = "Restore Hyprland display after resume";
      After = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-resume" ''
        sleep 2
        ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
        sleep 0.5
        ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "HDMI-A-1,3840x2160@60,2560x0,1.25,vrr,0"
        ${pkgs.hyprland}/bin/hyprctl keyword monitor ",preferred,auto,1"
        pidof swaylock || swaylock -f
      ''}";
      Environment = "WAYLAND_DISPLAY=wayland-1";
    };

    Install = {
      WantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    };
  };
}
