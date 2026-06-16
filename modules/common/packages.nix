{ lib, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      curl
      unzip
      # Rust coreutils
      uutils-coreutils-noprefix
    ];
  };
}
