{
  qt = {
    enable = true;

    style = {
      name = "kvantum";
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };
}
