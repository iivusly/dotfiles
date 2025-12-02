{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    services.syncthing = {
      enable = false; # TODO: only enable on certain networks
    };
  };
}
