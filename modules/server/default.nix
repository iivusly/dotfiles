{ ... }:
{
  imports = [
    ./ssh.nix
    ./networking.nix
    ./sops.nix
    ./users.nix
    ./immich.nix
    ./copyparty.nix
    ./tailscale.nix
    ./qbittorrent.nix
    ./jellyfin.nix
    ./navidrome.nix
  ];

  time.timeZone = "America/Vancouver";
  system.stateVersion = "25.11";
}
