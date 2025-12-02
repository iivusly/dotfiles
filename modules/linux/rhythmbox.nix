{ config, pkgs, ... }:
{
  services.gvfs.enable = true;
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ rhythmbox ];
  };
}
