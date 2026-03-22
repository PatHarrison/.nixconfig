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
    ripgrep
    (btop.override { cudaSupport = true;})
    tree
    lshw
    inxi
    fd
    nmap
    mtr
    gvfs


    # Encryption
    gnupg

    # Editors
    neovim
    
    # Utils
    brightnessctl
    pavucontrol
    usbutils
    pciutils
    networkmanagerapplet
    numlockx

    # Dev
    python314
    pgadmin4-desktopmode
    postgresql
    pgcli

    # Wayland Utilities
    wl-clipboard
    cliphist
    grim
    slurp

    libsForQt5.qt5.qtwayland
    qt6.qtwayland


    # Apps
    kitty

    (qgis.override {
      extraPythonPackages = ps:
        with ps; [
          numpy
          geopandas
          rasterio
        ];
    })
    grass
    # libreoffice-qt
    zathura
    texlive.combined.scheme-full
    inkscape
    gimp
    obs-studio

    thunar
    ranger
    thunderbird
    tumbler
    ffmpegthumbnailer
    foliate
    xarchiver

    swaylock-effects

    factorio

    # open-webui
  ];

  environment.pathsToLink = [
    "share/thumbnailers"
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
