{ config, pkgs, ... }:
{
  users.users.${config.user} = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$daAEsGbw9jxaZBF3uGhym/$2ApFrwIRRKNzETMDlTEdFT2CAQmcAiryEZ9HE62Iyg7";
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
