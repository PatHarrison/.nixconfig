{ pkgs, config, lib, ... }:
let
  C = config.lib.stylix.colors;
  mod = "$mainMod";
in
{
  # Absorbs hyprland-unlock.nix
  systemd.user.services.hyprland-unlock = {
    Unit = {
      Description = "Restore Hyprland display after resume";
      After = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-resume" ''
        sleep 2
        hyprctl dispatch dpms off
        sleep 0.5
        hyprctl dispatch dpms on
        hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
        hyprctl keyword monitor "HDMI-A-1,3840x2160@60,2560x0,1.25,vrr,0"
        hyprctl keyword monitor ",preferred,auto,1"
        pidof swaylock || swaylock -f
      ''}";
      Environment = "WAYLAND_DISPLAY=wayland-1";
    };
    Install.WantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      windowrule = [
        "opacity 0.97 0.90, match:class ^(zen|thunar|thunderbird|kitty|obsidian|connection)$"
        "float on, match:class ^(zen) match:title ^(Opening|Save|Enter name)$"
      ];

      monitor = [
        "eDP-1,2560x1600@60,0x0,1"
        "HDMI-A-1,3840x2160@60,2560x0,1.25,vrr,0"
        ",preferred,auto,1"
      ];

      general = { border_size = 2; gaps_in = 4; gaps_out = 8; layout = "dwindle"; };
      dwindle = { pseudotile = true; preserve_split = true; };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        numlock_by_default = true;
        float_switch_override_focus = 2;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      decoration.blur = {
        enabled = true; size = 3; passes = 1;
        ignore_opacity = false; new_optimizations = true;
        popups = false; noise = 0.0; contrast = 1.0; brightness = 1.5;
      };

      animations.enabled = true;

      exec-once = [
        "swaybg -i /home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg -m fill"
        "waybar"
        "sleep 2 && hyprctl dispatch dpms on"
      ];

      misc = { force_default_wallpaper = 0; disable_hyprland_logo = true; };

      "${mod}" = "mod4";

      bind = let ss = "hyprshot -m"; date = "$(date +%Y-%m-%d_%H-%M-%S)"; pics = "~/Pictures/screenshots -f"; in [
        "${mod}, Return, exec, kitty"
        "${mod}, Q, killactive,"
        "${mod}, M, exit,"
        "${mod}, E, exec, thunar"
        "${mod}, V, togglefloating,"
        "${mod}, R, exec, rofi -show drun"
        "${mod}, P, pseudo,"
        "${mod}, S, togglesplit,"
        "${mod}, B, exec, zen"
        "${mod}, F, fullscreen"
        ''${mod}, W, exec, ${ss} window -o ${pics} "${date}".png''
        ''${mod}, A, exec, ${ss} region -o ${pics} "${date}".png''
        "${mod}, ESCAPE, exec, swaylock -f; systemctl --user start hyprland-unlock"

        # Audio
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioPlay, exec, playerctl play-pause"

        # Brightness
        ",XF86MonBrightnessDown, exec, brightnessctl -q -d intel_backlight set 10%-"
        ",XF86MonBrightnessUp, exec, brightnessctl -q -d intel_backlight set 10%+"
      ] ++
      # Focus/move/resize — generated from direction map
      (builtins.concatLists (map ({ key, dir }: [
        "${mod}, ${key}, movefocus, ${dir}"
        "${mod} SHIFT, ${key}, movewindow, ${dir}"
        "${mod} CTRL, ${key}, resizeactive, ${if dir == "l" then "-20 0" else if dir == "r" then "20 0" else if dir == "u" then "0 -20" else "0 20"}"
      ]) [
        { key = "H"; dir = "l"; } { key = "L"; dir = "r"; }
        { key = "K"; dir = "u"; } { key = "J"; dir = "d"; }
      ])) ++
      # Workspaces — generated
      (builtins.concatLists (map (n: let ws = toString n; k = if n == 10 then "0" else ws; in [
        "${mod}, ${k}, workspace, ${ws}"
        "${mod} SHIFT, ${k}, movetoworkspace, ${ws}"
      ]) (lib.range 1 10))) ++ [
        "${mod} CTRL, right, workspace, r+1"
        "${mod} CTRL, left, workspace, r-1"
      ];
    };
  };
}
