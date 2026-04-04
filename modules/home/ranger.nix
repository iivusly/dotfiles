{ pkgs, ... }: {
  programs.ranger = {
    enable = true;

    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      draw_borders = true;
      show_hidden = true;
    };

    extraConfig = ''
      default_linemode devicons
    '';

    plugins = [
      {
        name = "ranger_tmux";
        src = pkgs.fetchFromGitHub {
          owner = "joouha";
          repo = "ranger_tmux";
          rev = "05ba5ddf2ce5659a90aa0ada70eb1078470d972a";
          hash = "sha256-KCBOPwhG4U/k2a/Dp/+fZeetFz/PW9424zi3NlLsDj0=";
        };
      }
      {
        name = "ranger_devicons";
        src = pkgs.fetchFromGitHub {
          owner = "alexanderjeurissen";
          repo = "ranger_devicons";
          rev = "1bcaff0366a9d345313dc5af14002cfdcddabb82";
          hash = "sha256-qvWqKVS4C5OO6bgETBlVDwcv4eamGlCUltjsBU3gAbA=";
        };
      }
    ];
  };
}
