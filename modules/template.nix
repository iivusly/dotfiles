# This is just a template module, does not do anything lol
{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ ];
  };
}
