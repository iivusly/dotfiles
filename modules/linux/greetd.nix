{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.wayland.windowManager.sway.package}/bin/sway";
        user = "iivusly";
      };
    };
  };
}
