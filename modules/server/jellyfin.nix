{ ... }: {
  services.jellyfin = {
    enable = true;
    group = "storage";
    openFirewall = true;
  };
}
