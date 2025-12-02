{ config, pkgs, ... }:
{
    # fonts.fontconfig = { enable = true; };
    home.packages =
      with pkgs;
      [ jetbrains-mono ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
