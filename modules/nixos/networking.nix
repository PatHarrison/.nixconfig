{ config, pkgs, lib, ... }:

{
  networking.hostName = "odin";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "192.168.68.111" "1.1.1.1"];
  networking.firewall.allowedTCPPorts = [ 8082 ];
}
