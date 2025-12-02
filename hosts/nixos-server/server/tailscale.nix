{ config, ... }: {
  services.tailscale = {
    enable = true;
    authKeyFile = "/run/secrets/tailscale/nixos_server"; # TODO: bind to sops-nix
  };
}
