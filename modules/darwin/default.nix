let
  files = builtins.readDir ./.;

  nixFiles = builtins.filter (name: name != "default.nix" && builtins.match ".*\\.nix" name != null) (
    builtins.attrNames files
  );

  imports = map (name: ./. + "/${name}") nixFiles;
in
{
  system.stateVersion = 5;

  imports = imports ++ [ ../common ];

  # TODO: only replace when updated because this breaks desktop :\
  #system.activationScripts.extraActivation.text = ''
  #  # wallpaper
  #  echo "setting wallpaper..."
  #  osascript -e '
  #  tell application "System Events"
  #    set desktopCount to count of desktops
  #    repeat with i from 1 to desktopCount
  #      tell desktop i
  #        set picture to "${../../files/wallpapers/kittyboard-dark.png}"
  #      end tell
  #    end repeat
  #  end tell'
  #  echo "Wallpaper set successfully"
  #'';
}
