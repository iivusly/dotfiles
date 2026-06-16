{ config, pkgs, ... }:
{
  system.primaryUser = config.user;

  system.defaults.NSGlobalDomain = {
    NSAutomaticWindowAnimationsEnabled = false;
    NSWindowShouldDragOnGesture = true;
  };
}
