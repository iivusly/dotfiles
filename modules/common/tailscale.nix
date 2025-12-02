{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    # services.tailscale.enable = true;
  };

  services.tailscale.enable = true;
}
