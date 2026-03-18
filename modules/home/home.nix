{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hypr.nix
    ./hyprland-unlock.nix
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
    ./tmux.nix
    ./xdg.nix
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
    fastfetch 
    obsidian
    poetry

    hyprshot
    playerctl

    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  xdg.configFile."feh/keys".text = ''
    zoom_in        plus
    zoom_out       minus
    zoom_fit       f
    zoom_fill      F
    next_img       l
    prev_img       h
    quit           q
    toggle_fullscreen Return
  '';
}
