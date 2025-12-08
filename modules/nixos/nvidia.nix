{ config, pkgs, ... }:

{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaPersistenced = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta; # Use for Wayland
  };

  environment.variables = {
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    WLR_NO_HARDWARE_CURSORS = "1"; # Should Fix Mouse lag?
  };
}
