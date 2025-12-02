{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      wl-clipboard
      slurp
      grim
      spotify-qt
      librespot
    ];
  };
}
