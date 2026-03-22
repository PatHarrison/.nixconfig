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
    ./starship.nix
  ];

  home.stateVersion = "25.05";

  home.username = "patrick";
  home.homeDirectory = "/home/patrick";

  programs.home-manager.enable = true;

  programs.gpg = {
    enable = true;
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

  home.file.".zen/profiles.ini".text = ''
    [Profile0]
    Name=pat
    IsRelative=1
    Path=pat
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';
  home.file.".zen/pat/user.js".text = ''
    // Password manager
    user_pref("signon.rememberSignons", true);
    user_pref("signon.autofillForms", true);

    // Restore previous session
    user_pref("browser.startup.page", 3);

    // Smooth scrolling
    user_pref("general.smoothScroll", true);

    // Compact UI density
    user_pref("browser.uidensity", 1);
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets",true);

    // Disable telemetry
    user_pref("datareporting.healthreport.uploadEnabled", false);
    user_pref("toolkit.telemetry.enabled", false);

    // Hardware acceleration (good with your Nvidia setup)
    user_pref("layers.acceleration.enabled", true);
    user_pref("gfx.webrender.all", true);
  '';
}
