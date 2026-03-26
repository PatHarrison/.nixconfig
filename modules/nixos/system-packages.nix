{ config, pkgs, lib, ... }:

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
    nvtopPackages.nvidia
    tree
    lshw
    inxi
    fd
    nmap
    mtr
    gvfs
    fastfetch 


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
    powertop
    ffmpegthumbnailer
    tumbler
    xarchiver

    # Dev
    python314

    # Wayland Utilities
    libsForQt5.qt5.qtwayland
    qt6.qtwayland

    # Apps
    kitty

  ];

  environment.pathsToLink = [
    "share/thumbnailers"
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
