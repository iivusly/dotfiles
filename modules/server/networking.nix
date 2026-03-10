{ ... }:
{
  networking = {
    hostName = "nixos-server";
    firewall.enable = false; # TODO: tailscale setup with firewall
  };
}
