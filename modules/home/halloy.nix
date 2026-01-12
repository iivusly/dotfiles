{ config, pkgs, ... }:
{
  sops.secrets = {
    "halloy/liberachat" = {};
    "halloy/osu" = {};
  };
  programs.halloy = {
    enable = true;
    settings = {
      notifications = {
        direct_message = {
          sound = "peck";
          show_toast = true;
        };
        highlight = {
          sound = "dong";
        };
      };
      servers = {
        liberachat = {
          server = "irc.libera.chat";
          nickname = "iivusly";
          nick_password_file = config.sops.secrets."halloy/liberachat".path;
        };
        osu = {
          server = "irc.ppy.sh";
          port = 6667;
          use_tls = false;
          nickname = "iivusly";
          nick_password_file = config.sops.secrets."halloy/osu".path;
        };
        redacted = {
          server = "irc.scratch-network.net";
          nickname = "me0wzers";
        };
        orpheus = {
          server = "irc.orpheus.network";
          nickname = "me0wzers";
        };
      };
    };
  };
}
