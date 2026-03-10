{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = lib.mkForce "IosevkaTerm Nerd Font Mono";
  };
}
