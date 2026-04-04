{ config, pkgs, ... }:
{
  services.aerospace = {
    enable = true;
    settings = {
      # Reference: https://github.com/i3/i3/blob/next/etc/config

      #key-mapping = {
      #  key-notation-to-key-code = {
      #    mod = "option";
      #  };
      #};

      # i3 doesn't have "normalizations" feature that why we disable them here.
      # But the feature is very helpful.
      # Normalizations eliminate all sorts of weird tree configurations that don't make sense.
      # Give normalizations a chance and enable them back.
      enable-normalization-flatten-containers = false;
      enable-normalization-opposite-orientation-for-nested-containers = false;

      # Mouse follows focus when focused monitor changes
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      # Gaps between windows (inner-*) and between monitor edges (outer-*).
      # Possible values:
      # - Constant:     gaps.outer.top = 8
      # - Per monitor:  gaps.outer.top = [{ monitor.main = 16 }, { monitor."some-pattern" = 32 }, 24]
      #                 In this example, 24 is a default value when there is no match.
      #                 Monitor pattern is the same as for 'workspace-to-monitor-force-assignment'.
      #                 See: https://nikitabobko.github.io/AeroSpace/guide.html#assign-workspaces-to-monitors

      gaps.inner.horizontal = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 12; }
        10
      ];
      gaps.inner.vertical = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 12; }
        10
      ];
      gaps.outer.left = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 30; }
        10
      ];
      gaps.outer.bottom = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 30; }
        10
      ];
      gaps.outer.top = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 60; }
        30
      ];
      gaps.outer.right = [
        { monitor."built-in" = 10; }
        { monitor."acer" = 30; }
        10
      ];

      workspace-to-monitor-force-assignment = {
        "1" = "main";
        "2" = "main";
        "3" = "main";
        "4" = "main";
        "5" = "main";
        "6" = "secondary";
        "7" = "secondary";
        "8" = "secondary";
        "9" = "secondary";
        "10" = "secondary";
      };

      exec-on-workspace-change = [
        "${pkgs.bash}/bin/bash"
        "-c"
        "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];

      mode.main.binding = {
        alt-enter = "exec-and-forget ${pkgs.lib.getExe pkgs.kitty} --single-instance --directory ~";
        alt-shift-enter = "exec-and-forget open http://";

        # i3 wraps focus by default
        alt-h = "focus --boundaries-action wrap-around-the-workspace left";
        alt-j = "focus --boundaries-action wrap-around-the-workspace down";
        alt-k = "focus --boundaries-action wrap-around-the-workspace up";
        alt-l = "focus --boundaries-action wrap-around-the-workspace right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Consider using "join-with"; command as a "split"; replacement if you want to enable
        # normalizations
        alt-s = "split horizontal";
        alt-v = "split vertical";

        alt-f = "fullscreen";

        alt-shift-s = "layout v_accordion"; # "layout stacking"; in i3
        alt-shift-w = "layout h_accordion"; # "layout tabbed"; in i3
        alt-e = "layout tiles horizontal vertical"; # "layout toggle split"; in i3

        alt-shift-space = "layout floating tiling"; # "floating toggle"; in i3

        # Not supported, because this command is redundant in AeroSpace mental model.
        # See: https://nikitabobko.github.io/AeroSpace/guide#floating-windows
        #alt-space = "focus toggle_tiling_floating";

        # `focus parent`/`focus child` are not yet supported, and it"s not clear whether they
        # should be supported at all https://github.com/nikitabobko/AeroSpace/issues/5
        # alt-a = "focus parent";

        alt-backtick = "workspace 0";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";

        alt-shift-backtick = "move-node-to-workspace 0";
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";

        alt-shift-c = "reload-config";

        alt-r = "mode resize";
      };

      mode.resize.binding = {
        h = "resize width -50";
        j = "resize height +50";
        k = "resize height -50";
        l = "resize width +50";
        enter = "mode main";
        esc = "mode main";
      };
    };
  };

  system.primaryUser = config.user;

  system.defaults.NSGlobalDomain = {
    NSAutomaticWindowAnimationsEnabled = false;
    NSWindowShouldDragOnGesture = true;
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xff${config.home-manager.users.${config.user}.lib.stylix.colors.base05}";
    inactive_color = "0xff${config.home-manager.users.${config.user}.lib.stylix.colors.base03}";
    width = 5.0;
  };

  home-manager.users.${config.user} =
    let
      stylix = config.home-manager.users.${config.user}.lib.stylix;
    in
    {
      programs.sketchybar = {
        enable = true;
        configType = "lua";
        sbarLuaPackage = pkgs.unstable.sbarlua;
        config = ''
          local config_dir = "${../../files/sketchybar}"
          package.path = config_dir .. "/?.lua;" .. config_dir .. "/?/init.lua;" .. package.path

          _G.COLORS = {
            BAR_COLOR = "0xcc${stylix.colors.base00}",
            ITEM_BG_COLOR = "0xff${stylix.colors.base01}",
            TEXT_COLOR = "0xff${stylix.colors.base05}",
          }

          require("init")
        '';
      };
    };
}
