{ pkgs, ... }:
{
  programs.gh = {
    enable = true;

    gitCredentialHelper.enable = true;

    extensions = with pkgs; [
      gh-s
      gh-i
      gh-f
      gh-poi
      gh-eco
      gh-dash
    ];

    settings = {
      git_protocol = "ssh";
    };
  };
}
