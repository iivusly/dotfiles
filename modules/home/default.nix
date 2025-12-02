{ config, lib, globals, ... }:
let
  util = import ../../util { inherit lib; };
in
{
  imports = (util.importFiles ./.) ++ [
    ../../config/wallpaper.nix
  ];

    home.stateVersion = "25.11";
}
