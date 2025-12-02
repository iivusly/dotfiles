{ lib, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      curl
      unzip
      # Rust coreutils
      uutils-coreutils-noprefix

      telegram-desktop
      supersonic
      # discord # breaks on macos?
      element-desktop
      obsidian
      prismlauncher
      qbittorrent
      pkgs.unstable.osu-lazer-bin
      audacity
    ];

    variables = { };
  };
}
