{ config, pkgs, lib, ... }:

{
  networking.hostName = "odin";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8082 ];
}
