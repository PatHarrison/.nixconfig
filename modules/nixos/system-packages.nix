{ config, pkgs, lib, ... }:

{
  programs.hyprland.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    unzip
    zip
    btop
    tree

    # Encryption
    gnupg

    # Editors
    neovim
    
    # Utils
    brightnessctl
    pavucontrol

    # Dev
    python314

    # Wayland Utilities
    wl-clipboard
    cliphist
    grim
    slurp

    networkmanagerapplet

    # Apps
    kitty
    pgadmin4-desktopmode

    qgis
    grass
    libreoffice-qt
    zathura
    texlive.combined.scheme-full
    inkscape
    gimp
    obs-studio

    xfce.thunar
    thunderbird
  ];
  
  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
    hack
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
