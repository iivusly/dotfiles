# TODO: turn vesktop into a system package, so we can config it with nix ^_^
{ pkgs, ... }:
{
  home.packages = with pkgs; [ vesktop ];
}
