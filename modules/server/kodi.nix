{ config, pkgs, ... }:
{
  users.groups.media = { };
  users.extraUsers.kodi.isNormalUser = true;
  users.extraUsers.kodi.group = "media";

  services.cage.user = "kodi";
  services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  services.cage.enable = true;

  specialisation.no_kodi.configuration.boot.kernelParams = [ "systemd.mask=cage-tty1.service" ];
}
