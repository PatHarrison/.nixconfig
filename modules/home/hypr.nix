{ pkgs, config, lib, ... }:

let
  colors = config.lib.stylix.colors; # Stylix-exposed Base16 palette
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Minimal Hyprland config
    settings = {
      monitor = [
        "eDP-1,2560x1600@60,0x0,1"
        "HDMI-A-1,3840x2160@60,2560x0,1.25,vrr,0"
        
        # Fallback for any other monitors
        ",preferred,auto,1"
      ];

      general = {
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;
        layout = "dwindle";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        float_switch_override_focus = 2;
        kb_layout = "us";
        follow_mouse = 1;
        numlock_by_default = true;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0;
      };

      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = false;
          new_optimizations = true;
          popups = false;
          noise = 0.0;
          contrast = 1.0;
          brightness = 1.5;
        };
      };

      animations = {
        enabled = true;
      };

      exec-once = [
        "swaybg -i /home/patrick/.nixconfig/wallpapers/wallpaper2.jpeg -m fill"
        "waybar"
      ];

      windowrulev2 = [
      ];

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      "$mainMod" = "mod4";
      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, thunar"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, S, togglesplit,"
        "$mainMod, B, exec, zen"
        "$mainMod, F, fullscreen"
        ''$mainMod, W, exec, hyprshot -m window -o ~/Pictures/screenshots -f "$(date +%Y-%m-%d_%H-%M-%S)".png''
        ''$mainMod, A, exec, hyprshot -m region -o ~/Pictures/screenshots -f "$(date +%Y-%m-%d_%H-%M-%S)".png''

        # Audio controls
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioPlay, exec, playerctl play-pause"

        # Screen brightness
        ",XF86MonBrightnessDown, exec, brightnessctl -q -d intel_backlight set 10%-"
        ",XF86MonBrightnessUp, exec, brightnessctl -q -d intel_backlight set 10%+"

        # Move focus with mainMod + vim
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move window with mainMod + arrow keys
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # resize window with mainMod + arrow keys
        "$mainMod CTRL, H, resizeactive, -20 0"
        "$mainMod CTRL, L, resizeactive, 20 0"
        "$mainMod CTRL, K, resizeactive, 0 -20"
        "$mainMod CTRL, J, resizeactive, 0 20"
        
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Relative (monitor specific) workspace switcher
        "$mainMod CTRL, right, workspace, r+1"
        "$mainMod CTRL, left, workspace, r-1"

        "$mainMod, ESCAPE, exec, swaylock -f"
      ];
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "${colors.base00}";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "${colors.base00}";
      show-failed-attempts = true;
      inside-color = "${colors.base01}";
      key-hl-color = "${colors.base0B}";
      ring-color = "${colors.base02}";
      text-color = "${colors.base05}";
    };
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof swaylock || swaylock -f";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

}
