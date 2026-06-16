{
  inputs,
  outputs,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
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
    ../../modules/shared
    ../../modules/server
  ];
}
