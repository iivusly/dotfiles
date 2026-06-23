{ lib, config, pkgs, ... }: let 
  toTile = item: if item ? app then {
     tile-data.file-data = {
       _CFURLString = item.app;
       _CFURLStringType = 0;
     };
   } else if item ? spacer then {
     tile-data = { };
     tile-type = if item.spacer.small then "small-spacer-tile" else "spacer-tile";
   } else if item ? folder then {
     tile-data.file-data = {
       _CFURLString = "file://" + item.folder;
       _CFURLStringType = 15;
     };
     tile-type = "directory-tile";
   } else if item ? file then {
     tile-data.file-data = {
       _CFURLString = "file://" + item.file;
       _CFURLStringType = 15;
     };
     tile-type = "file-tile";
   } else item;
in {
  targets.darwin.defaults = lib.optional pkgs.stdenv.hostPlatform.isDarwin {
    "com.apple.dock" = {
      persistent-apps = map toTile [
        { app = "/System/Applications/Apps.app"; }
        {
          app = "${
            config.programs.firefox.package
          }/Applications/Firefox.app";
        }
        { app = "${pkgs.whatsapp-for-mac}/Applications/WhatsApp.app"; }
        { app = "${pkgs.thunderbird}/Applications/Thunderbird.app"; }
        { app = "${pkgs.supersonic}/Applications/Supersonic.app"; }
        { app = "${config.programs.kitty.package}/Applications/kitty.app"; }
      ];
    };
  };

  home.activation.restartDock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run /usr/bin/killall Dock || true
  '';
}
