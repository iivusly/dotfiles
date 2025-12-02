{ config, pkgs, ... }:
{
  home-manager.users.${config.user}.services.kdeconnect = {
    enable = true;
  };
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
}
