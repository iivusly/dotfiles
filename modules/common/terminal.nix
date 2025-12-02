{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.${config.user} = {
    programs = {
      alacritty = {
        enable = true;
        settings.env.TERM = "xterm-256color";
        settings.font.normal.family = lib.mkForce "IosevkaTerm Nerd Font Mono";
      };

      tmux = {
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

      direnv = {
        enable = true;
      };

      btop.enable = true;

      git = {
        enable = true;

        userName = "${config.user}";
        userEmail = "${config.github-email}";

        ignores = [ ".DS_Store" ];
      };

      gh = {
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

      bat.enable = true;

      eza = {
        enable = true;
        git = true;
        icons = "auto";
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh = {
        enable = true;
        enableCompletion = true;

        initContent = ''
          nsr() {
            nix-shell -p "$1" --run "$1 $@"
          }
        '';

        shellAliases = {
          ns = "nix-shell -p";
          cat = "bat";
          ls = "eza";
          n = "nvim";
          cd = "z";
          npm = "pnpm";
        };
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
