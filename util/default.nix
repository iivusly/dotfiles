{ lib, ... }:
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

  importDirs = base: let 
    contents = builtins.readDir base;
    dirs = builtins.filter (
      name: contents.${name} == "directory" && builtins.pathExists (base + "/${name}/default.nix")
    ) (builtins.attrNames contents);
  in map (name: base + "/${name}") dirs;
}
