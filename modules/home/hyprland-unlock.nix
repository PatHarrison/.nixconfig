{ pkgs, ... }:

{
  systemd.user.services.hyprland-unlock = {
    Unit = {
      Description = "Refresh Hyprland after unlock";
      After = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-refresh" ''
        sleep 1
        ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
        ${pkgs.hyprland}/bin/hyprctl reload
      ''}";
    };
  };
}
