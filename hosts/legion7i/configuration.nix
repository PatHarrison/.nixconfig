{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot.nix          # Bootloader, kernel params, i2c
    ../../modules/nixos/nvidia.nix        # Nvidia drivers & settings
    ../../modules/nixos/system-packages.nix
    ../../modules/nixos/networking.nix    # Hostname, NM, timezone, locale
    ../../modules/nixos/services.nix      # SSH, printing, udiskie, openrgb, libinput, etc.
    ../../modules/nixos/stylix.nix        # Stylix base16 theming
    ../../modules/nixos/locale.nix        # Optional locale tweaks
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.patrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
  };

  # --------- SYSTEM STATE VERSION ---------- #
  system.stateVersion = "25.05"; # Do not change this unless you know what you're doing
  # ----------------------------------------- #
}
