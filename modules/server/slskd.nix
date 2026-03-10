{ ... }:
{
  services.slskd = {
    enable = true;
    group = "storage";
    settings = {
      remote_configuration = false;
      directories = {
        incomplete = "/tmp";
        downloads = "/mnt/storage/services/slskd/downloads";
      };
    };
  };
}
