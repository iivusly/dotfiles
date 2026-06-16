{ lib, ... }: {
  programs.kitty = {
    enable = true;

    font.name = lib.mkForce "IosevkaTerm Nerd Font Mono";
  };
}
