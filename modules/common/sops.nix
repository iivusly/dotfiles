{ config, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    age.sshKeyPaths = [ "/Users/${config.user}/.ssh/id_ed25519" ];
  };
}
