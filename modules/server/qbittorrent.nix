{config, ...}: {
  services.qbittorrent = {
    enable = true;
    webuiPort = 1337;
  };
}
