{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.home-manager.users.${config.user}.wayland.windowManager.sway.package}/bin/sway";
        user = config.user;
      };
    };
  };
}
