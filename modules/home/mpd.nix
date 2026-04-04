{ config, ... }: {
  services.mpd = {
    enable = true;

    musicDirectory = "${config.xdg.userDirs.music}/Library";
  };
}
