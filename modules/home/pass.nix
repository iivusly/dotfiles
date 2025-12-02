{ globals, pkgs, ... }:
{
  programs.browserpass.enable = true;
  #     home.packages = [ pkgs.unstable.qtpass ];
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
      exts.pass-update
      exts.pass-audit
    ]);
    settings = {
      PASSWORD_STORE_DIR = "/Users/${globals.user}/.password-store";
    }; # TODO: update path for unix
  };
}
