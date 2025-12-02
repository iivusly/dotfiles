{ config, pkgs, ... }:
let
  hdd = "/mnt/hdd";
in
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    containers.enable = true;

    arion = {
      backend = "podman-socket";
      projects = {
        "slskd".settings.services."slskd".service = {
          image = "slskd/slskd:latest";
          environment.SLSKD_REMOTE_CONFIGURATION = "true";
          restart = "unless-stopped";
          ports = [
            "5030:5030"
            "5031:5031"
            "50300:50300"
          ];
          volumes = [ "${hdd}/apps/slskd:/app" ];
        };

        "navidrome".settings.services."navidrome".service = {
          image = "deluan/navidrome:latest";
          ports = [ "4533:4533" ];
          restart = "unless-stopped";
          volumes = [
            "${hdd}/apps/navidrome:/data"
            "${hdd}/music:/music:ro"
          ];
        };
      };
    };
  };
}
