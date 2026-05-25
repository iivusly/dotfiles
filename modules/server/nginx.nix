{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "nixos-server" = {
        default = true;
        extraConfig = ''
          client_max_body_size 0;
        '';
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
