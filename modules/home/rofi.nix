{
  programs.rofi = {
    enable = true;

    extraConfig = {
      drun-data-dirs = "$XDG_DATA_DIRS:~/.local/share/flatpak/exports/share";
    };
  };
}
