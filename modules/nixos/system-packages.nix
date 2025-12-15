{ config, pkgs, lib, ... }:

let
  secrets = import ./secrets.nix;
in
{
  programs.hyprland.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    git-crypt
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
    openrgb

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

    factorio
  ];
  
  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
    hack
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    factorio = pkgs.factorio.override {
      username = secrets.factorioUsername;
      token = secrets.factorioToken;
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
