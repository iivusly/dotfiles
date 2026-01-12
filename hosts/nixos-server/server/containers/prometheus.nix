{lib, ...}: {
  prometheus = {
    autoStart = true;
    ephemeral = true;
    forwardPorts = [
      {
        containerPort = 9090;
      }
      {
        containerPort = 8080;
      }
    ];
    
    config = {...}: {
      services = {
        prometheus = {
          enable = true;
          scrapeConfigs = [
            {
              job_name = "navidrome";
              metrics_path = "/metrics";
              scheme = "http";
              static_configs = [
                {
                  targets = ["nixos-server:4533"];
                }
              ];
            }
          ];
        };
        grafana = {
          enable = true;
          settings = {
            server = {
              http_addr = "0.0.0.0";
              http_port = 8080;
            };
          };
        };
      };

      networking.useDHCP = lib.mkDefault true;
      networking.firewall.allowedTCPPorts = [ 8080 9090 ];
      system.stateVersion = "25.11";
    };
  };
}
