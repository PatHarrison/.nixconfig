{ config, pkgs, lib, ... }:

{
  # System Locale
  i18n = {
    defaultLocale = "en_US.UTF-8";   # system default locale
  };

  # Keyboard layout
  console = {
    keyMap = "us";          # keyboard layout for TTYs
  };

  # Timezone
  time.timeZone = "America/Edmonton";  # could also live in a separate module
}
