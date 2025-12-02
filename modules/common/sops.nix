{ config, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    age.sshKeyPaths = [ "/Users/iivusly/.ssh/id_ed25519" ];
    secrets."tailscale/nixos_server" = {};
  };
}
