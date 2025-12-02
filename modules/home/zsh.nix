{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ns = "nix-shell -p";
      cat = "${pkgs.bat}/bin/bat";
      ls = "${pkgs.eza}/bin/eza";
      n = "nvim";
      #          cd = "${pkgs.zoxide}/bin/zoxide";
    };
  };
}
