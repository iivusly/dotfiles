{ config, ... }:
{
  sops.secrets."tailscale/nixos_server" = {
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.sops.secrets."tailscale/nixos_server".path;
    useRoutingFeatures = "server";
    extraUpFlags = [ "--ssh" ];
  };
}
