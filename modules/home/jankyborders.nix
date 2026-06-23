{ config, pkgs, ... }: {
  services.jankyborders = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    settings = {
      active_color = "0xff${config.lib.stylix.colors.base05}";
      inactive_color = "0xff${config.lib.stylix.colors.base03}";
      width = 5.0;
    };
  };
}
