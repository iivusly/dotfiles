{ lib }:
{
  systemdService =
    {
      Description,
      ExecStart,
      Environment ? "",
    }:
    {
      Unit = {
        Description = Description;
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Environment = Environment;
        ExecStart = ExecStart;
        Restart = "on-failure";
        RestartSec = 10;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  GatherModules = Directory: {
  };
  importFiles =
    dir:
    let
      entries = builtins.readDir dir;
      isFile = name: type: type == "regular" && name != "default.nix";
      files = lib.attrNames (lib.filterAttrs isFile entries);
      modulePaths = (map (name: dir + "/${name}") files);
      existingModules = lib.filter (path: builtins.pathExists path) modulePaths;
    in
    existingModules;
}
