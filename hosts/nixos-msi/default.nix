{
  inputs,
  outputs,
  ...
}: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    util = (import ../../util);
    inherit outputs;
  };

  modules = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ./hardware-configuration.nix
    ../../modules/shared
    ../../modules/linux
  ];
}
