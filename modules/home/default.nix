{
  config,
  lib,
  globals,
  ...
}:
let
  util = import ../../util { inherit lib; };
in
{
  imports = (util.importFiles ./.) ++ [
    ../../config/wallpaper.nix
  ];

  home = {
    sessionVariables = {
      LANG = "en_CA.UTF-8";
      LC_ALL = "en_CA.UTF-8";
    };

    stateVersion = "26.05";
  };
}
