{ config, pkgs, lib, ... }:

{
  services.resolved.enable = true;
  services.udisks2.enable = true;
  services.libinput.enable = true;
  services.dbus.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.cnijfilter2 ];
  environment.etc."papersize".text = "letter";
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers.ensurePrinters = [];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];

  systemd.services.hyprland-resume = {
    description = "Re-initialize Hyprland monitors after resume";
    after = [ "suspend.target" "hibernate.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "patrick";
      Environment = "WAYLAND_DISPLAY=wayland-1 HOME=/home/patrick";
      ExecStart = "${pkgs.writeShellScript "hyprland-resume" ''
        sleep 2
        export HYPRLAND_INSTANCE_SIGNATURE=$(ls /tmp/hypr/ | head -1)
        export WAYLAND_DISPLAY=wayland-1
        export HOME=/home/patrick
        ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
        ${pkgs.hyprland}/bin/hyprctl keyword monitor "HDMI-A-1,3840x2160@60,2560x0,1.25,vrr,0"
      ''}";
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
    package = pkgs.openrgb-with-all-plugins;
  };

  services.upower.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    systemWide = false;
    wireplumber.enable = true;  # add this - ensures it's explicitly enabled
    wireplumber.extraConfig = {
      "10-disable-nvidia" = {
        "monitor.alsa.rules" = [{
          matches = [{ "node.name" = "~alsa_output.pci-0000_00_1f.*"; }];
          actions.update-props = {
            "session.suspend-timeout-seconds" = 0;
            "node.pause-on-idle" = false;
          };
        }];
      };
    };
  };

  security.rtkit.enable = true;

  systemd.user.services.udiskie = {
    description = "Automount USB drives with udiskie";
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie -t";
      Restart = "on-failure";
    };

    wantedBy = [ "default.target" ];
  };

  services.tumbler.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.mkDefault ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --time-format "%H:%M — %A, %B %d" \
          --cmd 'hyprland' \
          --user-menu \
          --user-menu-min-uid 1000 \
          --remember \
          --remember-session \
          --theme "border=white;text=yellow;prompt=green;time=green;action=blue;button=yellow;container=black;input=white"
        '';
        user = "greeter";
      };
    };
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
    thunar-archive-plugin
  ];

  services.gvfs.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      CUDA_VISIBLE_DEVICES = "0";
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
