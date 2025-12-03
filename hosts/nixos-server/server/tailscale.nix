{ config, ... }: {
  sops.secrets."tailscale/nixos_server" = {}; # Access secret as a file
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale/nixos_server".path;
  };
}
