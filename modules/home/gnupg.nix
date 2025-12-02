{
  config,
  pkgs,
  lib,
  ...
}:
{
    home.packages = with pkgs; [ pinentry-gtk2 ];
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
}
