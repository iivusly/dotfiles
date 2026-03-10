{ config, pkgs, ... }:
{
  sops.secrets."copyparty/accounts/admin" = {
    owner = "copyparty";
  };

  services.copyparty = {
    enable = true;
    group = "storage";
    settings = {
      i = "0.0.0.0";
      p = [ 3923 ];
    };
    accounts = {
      admin.passwordFile = config.sops.secrets."copyparty/accounts/admin".path;
    };

    volumes = {
      "/" = {
        path = "/mnt/storage";
        access = {
          rwmda = [ "admin" ];
        };
      };
    };
  };
}
