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
    ./hardware-configuration.nix
    # ./disko-config.nix
    ./server
    ../../modules/common
    {
      time.timeZone = "America/Vancouver";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos-server";

      services.openssh = {
        enable = true;
      };

      networking.firewall.enable = false; # TODO: temp

      programs.git.enable = true;

      services.nfs.server = {
        enable = true;
        createMountPoints = true;
        exports = ''
          /export     100.64.0.0/10(rw,fsid=0,no_subtree_check,insecure,no_root_squash)
          /export/hdd 100.64.0.0/10(rw,no_subtree_check,insecure,no_root_squash,nohide)
        '';
      };

      system.stateVersion = "25.11";
    }
  ];
}
