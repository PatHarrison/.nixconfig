{ pkgs, ... }:

{
  services.swayidle = {
    enable = true;

    events = [
      { event = "before-sleep"; command = "swaylock -f"; }
      { event = "lock";         command = "swaylock -f"; }
    ];

    timeouts = [
      { timeout = 300; command = "swaylock -f"; }
      {
        timeout = 600;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
