{
  inputs = {
    arion = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/arion";
    };
    copyparty = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:9001/copyparty";
    };
    deploy-rs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:serokell/deploy-rs";
    };
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    firefox-addons = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    mac-app-util = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hraban/mac-app-util";
    };
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    };
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/nix-index-database";
    };
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-25.11";
    };
    nur = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nur";
    };
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
    sops-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/sops-nix";
    };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:danth/stylix/release-25.11";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      deploy-rs,
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
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
        };
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        # nixos-macbookpro = import ./hosts/nixos-macbookpro { inherit inputs outputs globals; };
        nixos-server = import ./hosts/nixos-server { inherit inputs outputs globals; };
      };

      darwinConfigurations = {
        MacBookPro-de-iivusly = import ./hosts/darwin-macbookpro { inherit inputs outputs globals; };
      };

      homeConfigurations = {
        # nixos-macbookpro = inputs.nixosConfigurations.nixos-macbookpro.config.home-manager.users.${globals.user}.home;
        MacBookPro-de-iivusly =
          inputs.darwinConfigurations.darwin-macbookpro.config.home-manager.users.${globals.user}.home;
      };

      deploy = {
        remoteBuild = true;
        nodes = {
          nixos-server = {
            hostname = "nixos-server";
            profiles.system = {
              user = "root";
              sshUser = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixos-server;
            };
          };
        };
      };

      # checks.x86_64-linux = deploy-rs.lib.x86_64-linux.deployChecks self.deploy;
      checks = flake-utils.lib.eachDefaultSystemPassThrough (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          deploy-rs-checks = deploy-rs.lib.${system}.deployChecks self.deploy;
        in
        with pkgs;
        lib.optionalAttrs stdenv.isLinux deploy-rs-checks
        // {
          # Your other usual checks can go here, e.g. deadnix, formatter, pre-commit, ...
        }
      );

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
            deploy-rs.packages.aarch64-darwin.deploy-rs
            openssh
          ];
          shellHook = ''
            export EDITOR=vi
          '';
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
