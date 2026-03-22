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
        modules-right = [ "custom/media" "custom/gpu" "disk" "pulseaudio" "cpu" "memory" "temperature" "battery" "network" "tray" ];

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
        "custom/gpu" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{print \"GPU \" $1 \"%\"}'";
          interval = 3;
          format = "{}";
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          path = "/";
          interval = 30;
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
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: alpha(@base00, 0.85);
        border-bottom: 1px solid alpha(@base02, 0.5);
        color: @base05;
      }

      /* ── Workspaces ──────────────────────────────── */
      #workspaces {
        margin: 0 4px;
        padding: 0;
      }

      #workspaces button {
        padding: 0 8px;
        color: @base04;
        background: transparent;
        border-bottom: 2px solid transparent;
        transition: all 0.2s ease;
        min-width: 24px;
      }

      #workspaces button.active {
        color: @base05;
        border-bottom: 2px solid @base0B;
      }

      #workspaces button.occupied {
        color: @base05;
        border-bottom: 2px solid @base03;
      }

      #workspaces button:hover {
        background: alpha(@base01, 0.6);
        color: @base06;
        border-bottom: 2px solid @base0D;
      }

      #workspaces button.urgent {
        color: @base08;
        border-bottom: 2px solid @base08;
      }

      /* ── Window title ────────────────────────────── */
      #window {
        margin: 0 8px;
        color: @base04;
        font-style: italic;
      }

      /* ── Shared module pill style ────────────────── */
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #custom-media,
      #custom-gpu,
      #disk,
      #tray {
        padding: 2px 10px;
        margin: 3px 2px;
        background: alpha(@base01, 0.6);
        border: 1px solid alpha(@base02, 0.4);
        border-radius: 6px;
        transition: background 0.2s ease;
      }

      /* ── Clock ───────────────────────────────────── */
      #clock {
        color: @base05;
        font-weight: bold;
        letter-spacing: 0.5px;
      }

      /* ── Media ───────────────────────────────────── */
      #custom-media {
        color: @base0E;
        border-color: alpha(@base0E, 0.3);
      }

      #custom-media.Playing {
        color: @base0B;
        border-color: alpha(@base0B, 0.3);
      }

      #custom-media.Paused {
        color: @base04;
        border-color: transparent;
      }

      /* ── Battery ─────────────────────────────────── */
      #battery {
        color: @base0B;
      }

      #battery.charging {
        color: @base0B;
        border-color: alpha(@base0B, 0.4);
      }

      #battery.warning:not(.charging) {
        color: @base0A;
        border-color: alpha(@base0A, 0.4);
      }

      #battery.critical:not(.charging) {
        color: @base08;
        border-color: alpha(@base08, 0.6);
        animation-name: blink;
        animation-duration: 0.8s;
        animation-timing-function: ease-in-out;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      /* ── System stats ────────────────────────────── */
      #cpu {
        color: @base0D;
      }

      #memory {
        color: @base0E;
      }

      #custom-gpu {
        color: @base0C;
        border-color: alpha(@base0C, 0.3);
      }

      #disk {
        color: @base0F;
      }

      #temperature {
        color: @base0A;
      }

      #temperature.critical {
        color: @base08;
        border-color: alpha(@base08, 0.5);
      }

      /* ── Network ─────────────────────────────────── */
      #network {
        color: @base0D;
      }

      #network.disconnected {
        color: @base08;
        border-color: alpha(@base08, 0.4);
      }

      /* ── Audio ───────────────────────────────────── */
      #pulseaudio {
        color: @base05;
      }

      #pulseaudio.muted {
        color: @base03;
        border-color: alpha(@base03, 0.3);
      }

      /* ── Tray ────────────────────────────────────── */
      #tray {
        padding: 2px 6px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        border-color: @base08;
      }

      /* ── Blink animation ─────────────────────────── */
      @keyframes blink {
        to {
          background: alpha(@base08, 0.25);
          color: @base07;
        }
      }
    '';
  };
}
