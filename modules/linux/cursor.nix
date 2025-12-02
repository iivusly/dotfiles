# This is just a template module, does not do anything lol
{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };
}
