{ config, ... }:
{
  sops = {
    age.sshKeyPaths = [
      "/Users/iivusly/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/iivusly/.ssh/id_ed25519"
    ];
    defaultSopsFile = ./secrets.yaml;
  };
}
