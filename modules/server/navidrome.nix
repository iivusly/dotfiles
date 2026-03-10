{ lib, pkgs, ... }: {
  services.navidrome = {
    enable = true;
    package = pkgs.unstable.navidrome;
    group = "storage";
    openFirewall = true;
    settings = {
      Address = "0.0.0.0";
      MusicFolder = "/mnt/storage/music";
      DataFolder = "/mnt/storage/services/navidrome";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    # This stops the "WASM runtime panic"
    MemoryDenyWriteExecute = lib.mkForce false;
    
    # Ensure the service can see the mount point
    ReadWritePaths = [ "/mnt/storage" ];
  };
}
