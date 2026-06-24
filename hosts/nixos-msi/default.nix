{
  inputs,
  outputs,
  globals,
  ...
}: inputs.nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = {
    util = (import ../../util);
    firefox-addons = inputs.firefox-addons.packages.${system};
    inherit inputs outputs globals;
  };

  modules = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ./hardware-configuration.nix
    ../../modules/shared
    ../../modules/linux
     inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays = [
        outputs.overlays.unstable-packages
        inputs.rust-overlay.overlays.default
      ];

      user = globals.user;
      boot.loader.systemd-boot.enable = true;

      home-manager = {
        extraSpecialArgs = specialArgs;
        sharedModules = [
          {
            nixpkgs.overlays = [
              outputs.overlays.unstable-packages
              inputs.rust-overlay.overlays.default
            ];
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      home-manager.users.${globals.user} = {
        imports = [
          inputs.nix-index-database.homeModules.nix-index
          inputs.nixvim.homeModules.nixvim
          inputs.stylix.homeModules.stylix
          inputs.sops-nix.homeManagerModules.sops
          ../../modules/home
        ];
      };
    }
 ];
}
