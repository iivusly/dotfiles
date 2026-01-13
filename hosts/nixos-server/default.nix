{ inputs, globals, outputs, ... }:
inputs.nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = {
    util = (import ../../util);
    inherit outputs;
  };
  modules = [
    inputs.sops-nix.nixosModules.sops
    inputs.arion.nixosModules.arion
    inputs.disko.nixosModules.disko
    inputs.copyparty.nixosModules.default
    ./hardware-configuration.nix
    ./disko-config.nix
    # ./server
    ../../modules/common
    ../../modules/server
    {
      time.timeZone = "America/Vancouver";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos-server";

      services.openssh = {
        enable = true;
      };

      networking = {
        firewall = {
          enable = false; # TODO: renable firewall
        };
      };

      system.stateVersion = "25.11";
    }
  ];
}
