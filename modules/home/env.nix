# modules/home/env.nix
{ ... }:
{
  home.sessionVariables = {
    # Editor
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    LESS = "-R";

    # Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # Qt
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };
}
