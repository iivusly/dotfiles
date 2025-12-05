{ config, pkgs, ... }:
{
  programs.halloy = {
    enable = true;
    settings = {
      servers = {
        liberachat = {
          server = "irc.libera.chat";
          nickname = "iivusly";
          nick_password_file = config.sops.secrets."halloy/liberachat".path;
        };
      };
    };
  };
}
