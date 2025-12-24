{ config, pkgs, lib, ... }:

{
  networking.hostName = "odin";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "192.168.68.111" "1.1.1.1"];
  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_US.UTF-8";
}
