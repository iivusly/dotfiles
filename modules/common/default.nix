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
    ../../config/wallpaper.nix
    { _module.args.inputs = inputs; }
  ];

  config.home-manager = {
    # useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${config.user}.home.stateVersion = "25.05";

  };
  config.services.wallpaper = {
    enable = true;
    imagePath = ../../files/wallpapers/gruvbox_grid.png;
  };
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
