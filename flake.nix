# Do not modify! This file is generated.

{
  description = "The real nix file";
  inputs = {
    arion = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/arion";
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
    flakegen.url = "github:jorsn/flakegen";
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
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}
