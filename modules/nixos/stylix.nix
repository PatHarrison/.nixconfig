{ pkgs, config, ... }:

{
# modules/nixos/stylix.nix
stylix = {
  enable = true;
  polarity = "dark";
  base16Scheme = import ../../themes/mistwood.nix;

  cursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 16;
  };
};
}
