{ config, pkgs, lib, ... }:

{
  services.resolved.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.libinput.enable = true;
  services.dbus.enable = true;

  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.gutenprint pkgs.cnijfilter2 ];
  # environment.etc."papersize".text = "letter";
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };
  #
  # hardware.printers.ensurePrinters = [];

  #TODO: Figure out if this is needed
  services.thermald.enable = true;

  systemd.services.numlock = {
    description = "Enable numlock on boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.numlockx}/bin/numlockx on";
      RemainAfterExit = true;
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
    package = pkgs.openrgb-with-all-plugins;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

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

}
