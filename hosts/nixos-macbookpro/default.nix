{ inputs, globals, ... }:
inputs.nixpkgs.lib.nixosSystem rec {
  system = "aarch64-linux";
  specialArgs = {
    util = (import ../../util);
    firefox-addons = inputs.firefox-addons.packages.${system};
    network-dmenu = inputs.network-dmenu.defaultPackage.${system};
  };
  modules = [
    globals
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../modules/linux
    {
      time.timeZone = "America/Vancouver";

      hardware.asahi = {
        peripheralFirmwareDirectory = /boot/asahi;
        useExperimentalGPUDriver = true;
        experimentalGPUInstallMode = "replace";
        setupAsahiSound = true;
      };

      boot = {
        loader = {
          efi.canTouchEfiVariables = false;
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
        };
        # extraModprobeConfig = ''options hid_apple swap_opt_cmd=1 swap_fn_leftctrl=1 iso_layout=1'';
        initrd.systemd.enable = true;
      };

      home-manager.users.${globals.user}.imports = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.nix-index-database.hmModules.nix-index
        inputs.nixvim.homeModules.nixvim
      ];
    }
  ];
}
