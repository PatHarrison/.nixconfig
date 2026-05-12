{ config, pkgs, lib, ... }:

{
  networking.hostName = "odin";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
    allowPing = false;
  };
}
