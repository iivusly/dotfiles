{

  description = "The real nix file";

  inputs =
    let
      nixpkgsVersion = "25.11";

      isDarwin = true;

      dep = url: {
        inherit url;
        inputs.nixpkgs.follows = "nixpkgs";
      };
    in
    {
      nixpkgs.url = "github:NixOS/nixpkgs/nix${if isDarwin then "pkgs" else "os"}-${nixpkgsVersion}${
        if isDarwin then "-darwin" else ""
      }";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      nixlib.url = "github:nix-community/nixpkgs.lib";
      flake-utils.url = "github:numtide/flake-utils";

      rust-overlay = (dep "github:oxalica/rust-overlay");
      stylix = (dep "github:danth/stylix/release-${nixpkgsVersion}");

      nur = (dep "github:nix-community/nur");
      nix-darwin = (dep "github:nix-darwin/nix-darwin/nix-darwin-${nixpkgsVersion}");
      home-manager = (dep "github:nix-community/home-manager/release-${nixpkgsVersion}");

      nixvim = (dep "github:nix-community/nixvim/nixos-${nixpkgsVersion}");

      firefox-addons = (dep "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons");
      mac-app-util = (dep "github:hraban/mac-app-util");

      nix-index-database = (dep "github:Mic92/nix-index-database");
      sops-nix = (dep "github:Mic92/sops-nix");

      arion = (dep "github:hercules-ci/arion");
      disko = (dep "github:nix-community/disko");
    };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      globals = {
        user = "iivusly";
        github-email = "52052910+iivusly@users.noreply.github.com";
      };
      git-add = ''
        echo "staging changes in dotfiles..."
        git -C "$HOME/.dotfiles" add --intent-to-add --all
        # git -C $HOME/.dotfiles-private add --intent-to-add --automatically
      '';
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        nixos-macbookpro = import ./hosts/nixos-macbookpro { inherit inputs outputs globals; };
        nixos-server = import ./hosts/nixos-server { inherit inputs outputs globals; };
      };

      darwinConfigurations = {
        MacBookPro-de-iivusly = import ./hosts/darwin-macbookpro { inherit inputs outputs globals; };
      };

      homeConfigurations = {
        nixos-macbookpro =
          inputs.nixosConfigurations.nixos-macbookpro.config.home-manager.users.${globals.user}.home;
        MacBookPro-de-iivusly =
          inputs.darwinConfigurations.darwin-macbookpro.config.home-manager.users.${globals.user}.home;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        createApp =
          script:
          flake-utils.lib.mkApp {
            drv = (pkgs.writeShellScriptBin (builtins.hashString "md5" script) script);
          };
        nom = ""; # "--log-format internal-json -v |& ${pkgs.nix-output-monitor}/bin/nom --json"; # TODO: fix nom
        rebuild =
          if pkgs.stdenv.isDarwin then
            "nix run --extra-experimental-features nix-command --extra-experimental-features flakes -- nix-darwin"
          else
            "nixos-rebuild";
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            sops
            nix-output-monitor
          ];
          shellHook = '''';
        };
        apps = {
          git-add = createApp ''
            ${git-add}
          '';
          switch = createApp ''
            ${git-add}
            echo "switching nix system..."
            sudo ${rebuild} switch --flake "$HOME/.dotfiles" --impure $@ ${nom}
          '';
          build = createApp ''
            ${git-add}
            echo "building nix system..."
            ${rebuild} build --flake "$HOME/.dotfiles" --impure $@ ${nom}
          '';
          update = createApp ''
            ${git-add}
            echo "updating flake inputs..."
            nix flake update ${nom}
          '';
          generate = createApp ''
            echo "generating flake.nix..."
            nix run .#genflake flake.nix
          '';
          clean = createApp ''
            echo "cleaning up system..."
            nix-collect-garbage -d
          '';
          format = createApp ''
            echo "formatting dotfiles..."
            nix fmt
          '';
        };
      }
    );
}
