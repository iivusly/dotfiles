{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "nixos-server" = {
        default = true;
        locations = {
          "/slskd/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.slskd.settings.web.port}";
            proxyWebsockets = true;
          };
          "/files/" = {
            proxyPass = "http://127.0.0.1:${toString (builtins.head config.services.copyparty.settings.p)}";
            proxyWebsockets = true;
          };
        };
      };
    };
  };
}
