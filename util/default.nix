{ lib, ... }:
rec {
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
}
