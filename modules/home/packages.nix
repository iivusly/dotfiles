{ lib, pkgs, ... }:
with pkgs; {
  home.packages =
    [
      supersonic
      obsidian
      prismlauncher
      qbittorrent
      unstable.osu-lazer-bin
      audacity
      mpv
    ]
    #++ lib.optional stdenv.hostPlatform.isDarwin [

    #]
    ++ lib.optional stdenv.hostPlatform.isLinux [
      wl-clipboard
      slurp
      grim
      spotify-qt
      librespot
    ];
}
