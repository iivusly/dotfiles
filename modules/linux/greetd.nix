{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "iivusly";
      };
    };
  };
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ ];
  };
}
