{ config, pkgs, ... }:
{
  users.users.${config.user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
