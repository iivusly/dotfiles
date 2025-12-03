# external packages that have no home-manager config
{pkgs, ...}: {
  home.packages = with pkgs; [
      telegram-desktop
      supersonic
      element-desktop
      obsidian
      prismlauncher
      qbittorrent
      unstable.osu-lazer-bin
      audacity
  ];
}
