{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    mouse = true;
    terminal = "tmux-256color";
    escapeTime = 10;
    focusEvents = true;

    extraConfig = ''
      set -as terminal-features ',xterm*:RGB'
      set -as terminal-overrides ',xterm-256color:RGB'
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = tmux-sessionx;
        extraConfig = "set -g @sessionx-bind 'o'";
      }
    ];
  };
}
