{ lib, pkgs, ... }:
with pkgs; {
  home.packages =
    [
      supersonic
      prismlauncher
      qbittorrent
      unstable.osu-lazer-bin
      audacity
      mpv
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      the-unarchiver
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      wl-clipboard
      slurp
      grim
      spotify-qt
      librespot
    ];
}
