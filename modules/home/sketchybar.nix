{ config, pkgs, ... }: {
  programs.sketchybar = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    configType = "lua";
    config = ''
      local config_dir = "${../../files/sketchybar}";
      package.path = config_dir .. "/?.lua;" .. config_dir .. "/?/init.lua;" .. package.path;

      _G.COLORS = {
        BAR_COLOR = "0xcc${config.lib.stylix.colors.base00}",
        ITEM_BG_COLOR = "0xff${config.lib.stylix.colors.base01}",
        TEXT_COLOR = "0xff${config.lib.stylix.colors.base05}",
      }

      _G.AEROSPACE_COMMAND = "${config.programs.aerospace.package}/bin/aerospace"

      require("init")
    '';
  };
}
