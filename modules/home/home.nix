{ config, pkgs, ... }:

{
  imports = [
    ./hypr.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./kitty.nix
    ./bash.nix
    ./neovim.nix
    ./gtk.nix
    ./qt.nix
    ./electron.nix
    ./stylix-home.nix
    ./rofi.nix
    ./dunst.nix
    ./git.nix
  ];

  home.stateVersion = "25.05";

  home.username = "patrick";
  home.homeDirectory = "/home/patrick";

  programs.home-manager.enable = true;

  programs.gpg = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.default = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  home.packages = with pkgs; [
    neofetch 
    obsidian
    poetry

    hyprshot
    playerctl
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
