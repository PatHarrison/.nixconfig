{ pkgs, config, ... }:

{
  stylix = {
    enable = true;

    polarity = "dark";

    base16Scheme = import ../../themes/mistwood.nix;

    image = ../../wallpapers/wallpaper2.jpeg;


    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };
  };
}
