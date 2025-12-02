{ config, pkgs, ... }:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ config.user ];

  virtualisation.libvirtd.enable = true;
}
