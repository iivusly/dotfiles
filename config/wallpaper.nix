{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.services.wallpaper;
in
{
  options.services.wallpaper = {
    enable = lib.mkEnableOption "Enable wallpaper service";
    imagePath = lib.mkOption {
      type = lib.types.path;
      description = "Path to wallpaper";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isDarwin {
        home-manager.users.${config.user}.home.activation.set-wallpaper =
          inputs.home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ]
            ''
              /usr/bin/osascript -e '
                set desktopImage to POSIX file "${cfg.imagePath}"
                tell application "Finder"
                set desktop picture to desktopImage
                end tell'
            '';
      })
    ]
  );
}
