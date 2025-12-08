{
  qt = {
    enable = true;
    # platformTheme = "qtct";

    # Use kvantum theme via attribute set
    style = {
      name = "kvantum";
    };
  };

  home.sessionVariables = {
    QT_ENABLE_HIGHDPI_SCALING = "1";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };
}
