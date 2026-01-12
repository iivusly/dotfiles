{lib, ...}: {
  uptime-kuma = {
      autoStart = true;
      ephemeral = true;
      forwardPorts = [
        {
          containerPort = 8081;
        }
      ];
      bindMounts = {
        "/data" = {
          hostPath = "/mnt/hdd/apps/uptime-kuma";
          isReadOnly = false;
        };
      };
      config = {...}: {
        services.uptime-kuma = {
          enable = true;
          settings = {
            HOST = "0.0.0.0";
            PORT = "8081";
          };
        };

        networking.useDHCP = lib.mkDefault true;
        networking.firewall.allowedTCPPorts = [ 8081 ];
        system.stateVersion = "25.11";
      };
  };
}
