{ config, ... }:
{
  home-manager.users.${config.user} = {
    programs.kitty = {
      enable = true;
      settings = {
        background = "#181818";
      };
    };
  };
}
