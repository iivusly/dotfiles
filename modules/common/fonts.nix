# This is just a template module, does not do anything lol
{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    # fonts.fontconfig = { enable = true; };
    home.packages =
      with pkgs;
      [ jetbrains-mono ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
