{ config, ... }:
{
  sops.secrets.slskd_env = {
    sopsFile = ./secrets.yaml;
  };

  services.slskd = {
    enable = true;
    group = "storage";
    domain = null;
    environmentFile = config.sops.secrets.slskd_env.path;
    settings = {
      web.url_base = "/slskd";
      remote_configuration = false;
      directories = {
        incomplete = "/tmp";
        downloads = "/mnt/storage/services/slskd/downloads";
      };
      shares = {
        directories = [
          "/mnt/storage/music"
        ];
      };
    };
  };
}
