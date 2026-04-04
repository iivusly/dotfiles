{ lib, ... }:
{
  programs.alacritty = {
    enable = false;
    settings.font.normal.family = lib.mkForce "IosevkaTerm Nerd Font Mono";
  };
}
