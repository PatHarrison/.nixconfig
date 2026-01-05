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

  services.xserver.displayManager.sessionCommands = "${pkgs.numlockx}/bin/numlockx on";

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.mkDefault ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --cmd 'hyprland' \
          --user-menu \
          --user-menu-min-uid 1000 \
          --remember \
          --remember-session
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

}
