{ config, ... }: {
  services.jankyborders = {
    enable = true;
    settings = {
      active_color = "0xff${config.lib.stylix.colors.base05}";
      inactive_color = "0xff${config.lib.stylix.colors.base03}";
      width = 5.0;
    };
  };
}
