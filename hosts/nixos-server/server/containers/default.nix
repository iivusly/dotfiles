{lib, config, ...}: let
  contents = builtins.readDir ./.;
  nixFiles = lib.filterAttrs (name: type: type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name) contents;
  imported = lib.mapAttrs (name: _: import (./. + "/${name}") {inherit lib config;}) nixFiles;
in {
  containers = lib.foldl' lib.recursiveUpdate {} (lib.attrValues imported);
  sops.secrets."containers/slskd/environment" = {
    sopsFile = ./secrets.yaml;
  };
}
