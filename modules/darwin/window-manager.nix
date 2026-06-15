{ config, pkgs, ... }:
{
  system.primaryUser = config.user;

  system.defaults.NSGlobalDomain = {
    NSAutomaticWindowAnimationsEnabled = false;
    NSWindowShouldDragOnGesture = true;
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xff${config.home-manager.users.${config.user}.lib.stylix.colors.base05}";
    inactive_color = "0xff${config.home-manager.users.${config.user}.lib.stylix.colors.base03}";
    width = 5.0;
  };

  home-manager.users.${config.user} =
    let
      stylix = config.home-manager.users.${config.user}.lib.stylix;
    in
    {
      programs.sketchybar = {
        enable = true;
        configType = "lua";
        config = ''
          local config_dir = "${../../files/sketchybar}";
          package.path = config_dir .. "/?.lua;" .. config_dir .. "/?/init.lua;" .. package.path;

          _G.COLORS = {
            BAR_COLOR = "0xcc${stylix.colors.base00}",
            ITEM_BG_COLOR = "0xff${stylix.colors.base01}",
            TEXT_COLOR = "0xff${stylix.colors.base05}",
          }

          require("init")
        '';
      };
    };
}
