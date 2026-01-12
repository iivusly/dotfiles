{lib, ...}: {
  navidrome = {
      autoStart = true;
      ephemeral = true;
      forwardPorts = [
        {
          containerPort = 4533;
        }
      ];
      bindMounts = {
        "/music" = {
          hostPath = "/mnt/hdd/music";
          isReadOnly = true;
        };
        "/data" = {
          hostPath = "/mnt/hdd/apps/navidrome";
          isReadOnly = false;
        };
        "/cache" = {
          hostPath = "/mnt/hdd/apps/navidrome/cache";
          isReadOnly = false;
        };
      };
      config = {...}: {
        services.navidrome = {
          enable = true;
          settings = {
            Prometheus.Enabled = true;
            MusicFolder = "/music";
            DataFolder = "/data";
            CacheFolder = "/cache";
            Address = "0.0.0.0";
            Port = 4533;
          };
        };

        networking.useDHCP = lib.mkDefault true;
        networking.firewall.allowedTCPPorts = [ 4533 ];
        system.stateVersion = "25.11";
      };
  };
}
