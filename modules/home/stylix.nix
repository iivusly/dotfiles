{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";

    targets.firefox = {
      enable = true;
      colorTheme.enable = true;
      profileNames = [ "default" ];
    };
  };
}
