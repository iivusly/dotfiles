{
  config,
  lib,
  inputs,
  ...
}:
let
  files = builtins.readDir ./.;

  nixFiles = builtins.filter (name: name != "default.nix" && builtins.match ".*\\.nix" name != null) (
    builtins.attrNames files
  );

  imports = map (name: ./. + "/${name}") nixFiles;
in
{
  imports = imports ++ [
    { _module.args.inputs = inputs; }
  ];

  options = {
    github-email = lib.mkOption {
      type = lib.types.str;
      description = "GitHub email bc yes";
    };
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
  };
}
