{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  hardware.i2c.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [
    "nvidia_drm.modeset=1"
    "nvidia_drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "nvidia.NVreg_EnableGpuFirmware=0"
    "nvidia.NVreg_RestoreMemoryAllocations=1"  # add this
    "preempt=full"
    "acpi_osi=\"!Windows 2015\""
    "acpi_osi=Linux"
  ];

  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
  '';
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
