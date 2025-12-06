{lib, config, ...}: 
{
  slskd = {
    autoStart = true;
    ephemeral = true;
    forwardPorts = [
      {
        containerPort = 5030;
      }
      {
        containerPort = 50300;
      }
    ];

    bindMounts = {
      "/app" = {
        hostPath = "/mnt/hdd/apps/slskd";
        isReadOnly = false;
      };
      "/downloads" = {
        hostPath = "/mnt/hdd/downloads";
        isReadOnly = false;
      };
      "/environment" = {
        hostPath = config.sops.secrets."containers/slskd/environment".path;
        isReadOnly = true;
      };
    };

    config = {...}: {
      services.slskd = {
        enable = true;

        environmentFile = "/environment";

        domain = "0.0.0.0";

        settings = {
          shares = {
            directories = [ "/app/shares" ];
          };
          directories = {
            downloads = "/downloads";
          };
        };
      };

      networking.useDHCP = lib.mkDefault true;
      networking.firewall.allowedTCPPorts = [5030 50300];
      system.stateVersion = "25.11";
    };
  };
}
