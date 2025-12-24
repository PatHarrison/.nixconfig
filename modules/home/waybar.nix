{ config, pkgs, lib, ... }:

let
  colors = config.lib.stylix.colors; # pulls Base16 scheme from Stylix
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" "hyprland/window"];
        modules-center = [ "clock" ];
        modules-right = [ "custom/media" "pulseaudio" "cpu" "memory" "temperature" "battery" "network" "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 64;
          separate-outputs = true;
        };

        clock = {
          format = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#${colors.base0B}'><b>{}</b></span>";
              days = "<span color='#${colors.base05}'><b>{}</b></span>";
              weeks = "<span color='#${colors.base0D}'><b>W{}</b></span>";
              weekdays = "<span color='#${colors.base0A}'><b>{}</b></span>";
              today = "<span color='#${colors.base08}'><b><u>{}</u></b></span>";
            };
          };
        };

        "custom/media" = {
          format = "{icon} {text}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎵";
          };
          escape = true;
          exec = pkgs.writeShellScript "mediaplayer" ''
            player_status=$(${pkgs.playerctl}/bin/playerctl status 2>/dev/null)
            if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
              artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null)
              title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null)
              
              if [ -n "$artist" ] && [ -n "$title" ]; then
                echo "{\"text\":\"$artist - $title\", \"tooltip\":\"$artist - $title\", \"class\":\"$player_status\"}"
              fi
            else
              echo "{\"text\":\"\", \"tooltip\":\"No media playing\"}"
            fi
          '';
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
          interval = 2;
        };

        cpu.format = "CPU {usage}%";
        memory.format = "RAM {used:0.1f}G";

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{icon}  {capacity}%";
          format-plugged = "{icon}  {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [ " " " " " " " " " " ];
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}/{cidr}";
          tooltip-format = " {ifname} via {gwaddr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "⚠ Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}%";
          on-click = "pavucontrol";
          scroll-step = 2;
        };
      };
    };

    style = ''
      @define-color base00 #${colors.base00};
      @define-color base01 #${colors.base01};
      @define-color base02 #${colors.base02};
      @define-color base03 #${colors.base03};
      @define-color base04 #${colors.base04};
      @define-color base05 #${colors.base05};
      @define-color base06 #${colors.base06};
      @define-color base07 #${colors.base07};
      @define-color base08 #${colors.base08};
      @define-color base09 #${colors.base09};
      @define-color base0A #${colors.base0A};
      @define-color base0B #${colors.base0B};
      @define-color base0C #${colors.base0C};
      @define-color base0D #${colors.base0D};
      @define-color base0E #${colors.base0E};
      @define-color base0F #${colors.base0F};

      * {
        all: initial;
        background: transparent;
        border: none;
        border-radius: 0;
        font-family: "JetBrains Nerd Font";
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: alpha(@base00, 0.7);
        color: @base05;
      }
      
      #workspaces button {
        padding: 0 10px;
        color: @base05;
        background: transparent;
        border-bottom: 3px solid transparent;
        transition: all 0.3s ease;
      }
      
      #workspaces button.active {
        background: alpha(@base01, 0.5);
        border-bottom: 3px solid @base05;
      }
      
      #workspaces button:hover {
        background: alpha(@base01, 0.6);
        border-bottom: 3px solid @base0B;
      }
      
      #window {
        margin: 0 10px;
        color: @base06;
        background: transparent;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #custom-media
      #tray {
        padding: 0 10px;
        margin: 0 2px;
        background: alpha(@base01, 0.5);
        color: @base05;
        border-radius: 5px;
        transition: all 0.3s ease;
      }
      
      #clock {
        color: @base05;
      }
            
      #custom-media {
        color: @base0E;
      }
      
      #custom-media.Playing {
        color: @base0B;
      }
      
      #custom-media.Paused {
        color: @base0A;
      }
      
      #battery {
        color: @base05;
      }
      
      #battery.charging {
        color: @base0B;
      }
      
      #battery.warning:not(.charging) {
        color: @base0A;
      }
      
      #battery.critical:not(.charging) {
        color: @base08;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      #cpu {
        color: @base08;
      }
      
      #memory {
        color: @base0E;
      }
      
      #temperature {
        color: @base0C;
      }
      
      #temperature.critical {
        color: @base08;
      }
      
      #network {
        color: @base0D;
      }
      
      #network.disconnected {
        color: @base08;
      }
      
      #pulseaudio {
        color: @base05;
      }
      
      #pulseaudio.muted {
        color: @base0A;
      }
      
      @keyframes blink {
        to {
          background-color: alpha(@base09, 0.8);
        }
      }
    '';
  };
}
