{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    programs.halloy = {
      enable = true;
    };
  };
}
