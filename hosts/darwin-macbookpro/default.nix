{
  inputs,
  globals,
  outputs,
  ...
}:
inputs.nix-darwin.lib.darwinSystem rec {
  system = "aarch64-darwin";
  specialArgs = {
    util = (import ../../util);
    firefox-addons = inputs.firefox-addons.packages.${system};
    inherit outputs inputs globals;
  };
  modules = [
    globals
    inputs.sops-nix.darwinModules.sops
    # inputs.maximbaz-private.nixosModules.macos
    # inputs.mac-app-util.darwinModules.default # TODO: broken... https://github.com/hraban/mac-app-util/issues/39
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays = [
        outputs.overlays.unstable-packages
        inputs.rust-overlay.overlays.default
      ];

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
          ../../modules/home
        ];
      };
    }
    ../../modules/darwin
  ];
}
