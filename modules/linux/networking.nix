{ config, pkgs, ... }:
{
  networking.hostName = "nixos-macbookpro";
  # networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];
  networking.resolvconf.enable = true;
}
