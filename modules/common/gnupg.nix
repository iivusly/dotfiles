{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ pinentry-gtk2 ];
    programs.gpg = {
      enable = true;
    };

    # programs.gnupg = lib.mkIf pkgs.stdenv.isDarwin {
    #   agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    #   };
    # };

    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
}
