# TODO: turn vesktop into a system package, so we can config it with nix ^_^
{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ vesktop ];
  };
}
