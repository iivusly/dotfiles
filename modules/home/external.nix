# external packages that have no home-manager config
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    supersonic
    obsidian
    prismlauncher
    qbittorrent
    unstable.osu-lazer-bin
    audacity
    mpv
  ];
}
