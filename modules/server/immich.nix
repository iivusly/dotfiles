{ ... }: {
  services.immich = {
    enable = true;
    group = "storage";
    host = "0.0.0.0";
    openFirewall = true;
    redis.enable = true;
    mediaLocation = "/mnt/storage/photos";
  };
}
