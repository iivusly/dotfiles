{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      # Rust
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rustfmt"
          "rust-analyzer"
          "rust-src"
        ];
        targets = [
          "aarch64-apple-darwin"
          "x86_64-apple-darwin"
          "aarch64-unknown-linux-gnu"
          "x86_64-unknown-linux-gnu"
          "wasm32-unknown-unknown"
        ];
      })

      # NodeJS
      nodejs
      pnpm

      # C / C++
      cmake
    ];
  };
}
