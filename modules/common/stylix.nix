{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    };
  };
}
