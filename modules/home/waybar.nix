{ config, pkgs, lib, ... }:

let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 2;

        modules-left   = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right  = [
          "custom/media"
          "pulseaudio"
          "cpu"
          "custom/gpu"
          "memory"
          "disk"
          "temperature"
          "battery"
          "network"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{id}";
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 60;
          separate-outputs = true;
        };

        clock = {
          format = "{:%A %d %B  %H:%M}";
          format-alt = "{:%H:%M}";
          tooltip-format = "{:%A, %B %d %Y}";
          on-click = "mode";
        };

        pulseaudio = {
          format = "VOL {volume}%";
          format-muted = "VOL ---";
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_SINK@ 2%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_SINK@ 2%-";
          tooltip-format = "Sink: {desc}\nVolume: {volume}%";
          scroll-step = 2;
        };

        cpu = {
          format = "CPU {usage}%";
          interval = 2;
          tooltip-format = "CPU Usage: {usage}%\nLoad: {load}";
          on-click = "kitty --title btop -- btop";
        };

        "custom/gpu" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits | awk -F', ' '{printf \"GPU %d%%\", $1}'";
          tooltip = true;
          exec-on-event = false;
          interval = 2;
          format = "{}";
          on-click = "kitty --title=nvtop -e nvtop";
        };

        memory = {
          format = "RAM {used:0.1f}G";
          interval = 5;
          tooltip-format = "Used: {used:0.1f}G / {total:0.1f}G\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
          on-click = "kitty --title btop -- btop";
        };

        disk = {
          format = "DSK {percentage_used}%";
          path = "/";
          interval = 30;
          tooltip-format = "{path}\nUsed: {used} / {total}\nFree: {free}";
        };

        temperature = {
          thermal-zone = 0;
          critical-threshold = 85;
          format = "TMP {temperatureC}°C";
          format-critical = "HOT {temperatureC}°C";
          tooltip-format = "Temperature: {temperatureC}°C";
        };

        battery = {
          states = { warning = 30; critical = 15; };
          format = "BAT {capacity}%{icon}";
          format-charging = "BAT {capacity}%+";
          format-plugged = "BAT {capacity}%=";
          format-icons = [ "" "" "" "" "" ];
          tooltip-format = "{timeTo}\nPower: {power}W\nCycles: {cycles}";
          on-click = "kitty --title powertop -- sudo powertop";
        };

        network = {
          format-wifi = "NET {essid}";
          format-ethernet = "ETH {ipaddr}";
          format-disconnected = "NET ---";
          format-linked = "NET {ifname}";
          tooltip-format-wifi = "SSID: {essid}\nSignal: {signalStrength}%\nFreq: {frequency}GHz\nIP: {ipaddr}\nGW: {gwaddr}";
          tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}/{cidr}\nGW: {gwaddr}";
          tooltip-format-disconnected = "Disconnected";
          on-click-left = "nm-connection-editor";
          interval = 5;
        };

        "custom/media" = {
          format = "{}";
          return-type = "json";
          max-length = 36;
          escape = true;
          exec = pkgs.writeShellScript "mediaplayer" ''
            player_status=$(${pkgs.playerctl}/bin/playerctl status 2>/dev/null)
            if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
              artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null)
              title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null)
              album=$(${pkgs.playerctl}/bin/playerctl metadata album 2>/dev/null)
              status_icon=""
              [ "$player_status" = "Paused" ] && status_icon=""
              if [ -n "$artist" ] && [ -n "$title" ]; then
                echo "{\"text\":\"$status_icon $artist - $title\", \"tooltip\":\"$title\\n$artist\\n$album\", \"class\":\"$player_status\"}"
              fi
            else
              echo "{\"text\":\"\", \"tooltip\":\"No media playing\"}"
            fi
          '';
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
          on-scroll-up = "${pkgs.playerctl}/bin/playerctl next";
          on-scroll-down = "${pkgs.playerctl}/bin/playerctl previous";
          interval = 2;
        };

        tray = {
          spacing = 6;
          show-passive-items = true;
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
        font-family: "JetBrains Nerd Font Mono", "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        letter-spacing: 0.03em;
        min-height: 0;
      }

      window#waybar {
        background: alpha(@base00, 0.75);
        border-bottom: 1px solid alpha(@base02, 0.9);
        color: @base05;
      }

      /* ── Tooltip ─────────────────────────────────── */
      tooltip {
        background: alpha(@base01, 0.6);
        border: 1px solid @base02;
        border-radius: 2px;
        padding: 4px 8px;
        color: @base05;
        font-family: "JetBrains Nerd Font Mono", monospace;
        font-size: 12px;
      }

      tooltip label {
        color: @base05;
      }

      /* ── Workspaces ──────────────────────────────── */
      #workspaces {
        margin: 0 4px 0 2px;
        padding: 0;
      }

      #workspaces button {
        padding: 0 9px;
        color: @base03;
        background: transparent;
        border-bottom: 2px solid transparent;
        transition: all 0.15s ease;
        font-size: 11px;
        font-weight: bold;
      }

      #workspaces button.active {
        color: @base05;
        border-bottom: 2px solid @base0B;
        background: alpha(@base02, 0.3);
      }

      #workspaces button.occupied {
        color: @base04;
        border-bottom: 2px solid @base03;
      }

      #workspaces button:hover {
        color: @base06;
        border-bottom: 2px solid @base0D;
        background: alpha(@base02, 0.2);
      }

      #workspaces button.urgent {
        color: @base08;
        border-bottom: 2px solid @base08;
      }

      /* ── Window title ────────────────────────────── */
      #window {
        margin: 0 6px;
        color: @base03;
        font-style: italic;
        font-size: 10px;
      }

      /* ── Clock ───────────────────────────────────── */
      #clock {
        color: @base05;
        font-size: 13px;
        font-weight: bold;
        letter-spacing: 0.05em;
        padding: 0 12px;
      }

      /* ── Shared right-side widget style ──────────── */
      #pulseaudio,
      #cpu,
      #memory,
      #custom-gpu,
      #disk,
      #temperature,
      #battery,
      #network,
      #custom-media {
        padding: 0 10px;
        margin: 3px 2px;
        background: alpha(@base01, 0.2);
        border-left: none;
        border-radius: 10px;
        color: @base04;
        font-size: 12px;
        transition: color 0.2s ease, background 0.2s ease;
      }

      #pulseaudio:hover   { background: alpha(@base0A, 0.2); color: @base0A; }
      #cpu:hover          { background: alpha(@base0D, 0.2); color: @base0D; }
      #custom-gpu:hover   { background: alpha(@base0C, 0.2); color: @base0C; }
      #memory:hover       { background: alpha(@base0E, 0.2); color: @base0E; }
      #disk:hover         { background: alpha(@base0F, 0.2); color: @base0F; }
      #temperature:hover  { background: alpha(@base0A, 0.2); color: @base0A; }
      #battery:hover      { background: alpha(@base0B, 0.2); color: @base0B; }
      #network:hover      { background: alpha(@base0D, 0.2); color: @base0D; }

      /* Active/colored states */
      #pulseaudio { color: @base0A; border-color: @base0A; }
      #cpu        { color: @base0D; border-color: @base0D; }
      #custom-gpu { color: @base0C; border-color: @base0C; }
      #memory     { color: @base0E; border-color: @base0E; }
      #battery    { color: @base0B; border-color: @base0B; }
      #network    { color: @base0B; border-color: @base0B; }
      #disk       { color: @base0F; border-color: @base0F; }

      #pulseaudio.muted {
        color: @base03;
        border-color: @base03;
      }

      #temperature.critical {
        color: @base08;
        border-color: @base08;
        animation: blink 0.8s ease-in-out infinite alternate;
      }

      #battery.warning:not(.charging) {
        color: @base0A;
        border-color: @base0A;
      }

      #battery.critical:not(.charging) {
        color: @base08;
        border-color: @base08;
        animation: blink 0.8s ease-in-out infinite alternate;
      }

      #network.disconnected {
        color: @base08;
        border-color: @base08;
      }

      /* ── Media ───────────────────────────────────── */
      #custom-media {
        color: @base0E;
        border-color: @base0E;
      }

      #custom-media.Paused {
        color: @base03;
        border-color: @base03;
      }

      /* ── Tray ────────────────────────────────────── */
      #tray {
        padding: 0 10px;
        margin: 3px 2px 3px 3px;
        background: alpha(@base01, 0.7);
        border-left: none;
        border-radius: 3px;
      }

      #tray menu {
        background: @base01;
        border: 1px solid @base02;
        color: @base05;
      }

      #tray menu menuitem {
        background: @base01;
        color: @base05;
        padding: 4px 12px;
      }

      #tray menu menuitem:hover {
        background: @base02;
        color: @base06;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        border-color: @base08;
      }

      /* ── Blink ───────────────────────────────────── */
      @keyframes blink {
        to { background: alpha(@base08, 0.15); color: @base07; }
      }
    '';
  };
}
