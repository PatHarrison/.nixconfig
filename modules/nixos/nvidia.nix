{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaPersistenced = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime.sync.enable = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables = {
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    WLR_NO_HARDWARE_CURSORS = "1";
    HYPRLAND_NO_SD_NOTIFY = "1";
    WLR_DRM_NO_ATOMIC = "1";
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
  };
}
