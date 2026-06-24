{ config, lib, pkgs, ... }: {
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
    };
    services.gnome-keyring.enable = true;
    services.swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          event = "lock";
          command = "lock";
        }
      ];
      timeouts = [
        {
          timeout = 10 * 60;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 30 * 60;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        interval = 5;
      };

      modules = {
        "wireless _first_" = {
          position = 1;
          settings = {
            format_up = "W:%quality %essid %ip";
            format_down = "W: down";
          };
        };

        "ethernet _first_" = {
          position = 2;
          settings = {
            format_up = "E: %speed %ip";
            format_down = "E: down";
          };
        };

        "battery 0" = {
          position = 3;
          settings = {
            format = "%status %percentage %remaining";
            path = "/sys/class/power_supply/macsmc-battery/uevent";
          };
        };

        "disk /" = {
          position = 4;
          settings = {
            format = "%avail";
          };
        };

        load = {
          position = 5;
          settings = {
            format = "%1min";
          };
        };

        memory = {
          position = 6;
          settings = {
            format = "%used | %available";
            threshold_degraded = "1G";
            format_degraded = "MEMORY < %available";
          };
        };

        "volume master" = {
          position = 7;
          settings = {
            format = "V: %volume";
            format_muted = "V: MUTED";
            device = "default";
            mixer = "Master";
            mixer_idx = 0;
          };
        };

        "tztime local" = {
          position = 8;
          settings = {
            format = "%Y-%m-%d %H:%M:%S";
          };
        };
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      systemd.enable = true;
      wrapperFeatures.gtk = true;

      config = let 
        mod = "Mod4";
      in {
        modifier = mod;
        terminal = "${pkgs.kitty}/bin/kitty";
        input = {
          "type:*" = {
            natural_scroll = "enabled";
          };
        };
        keybindings = lib.mkOptionDefault {
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ .05+";
            "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ .05-";
            "XF86Search" = ''exec grim -g "$(slurp -c '#ff3f3faf' -w 2 -d -o)" -t png  - | wl-copy'';
            "${mod}+grave" = "workspace 0";
            "${mod}+shift+grave" = "move container to workspace 0";
            "${mod}+d" = "exec ${config.programs.rofi.package}/bin/rofi -show drun";
          };
        output = {
          "HDMI-A-1" = {
            pos = "3024 0";
          };
        };
        workspaceOutputAssign = [
          {
            workspace = "0";
            output = "DP-3";
          }
          {
            workspace = "1";
            output = "DP-3";
          }
          {
            workspace = "2";
            output = "DP-3";
          }
          {
            workspace = "3";
            output = "DP-3";
          }
          {
            workspace = "4";
            output = "DP-3";
          }
          {
            workspace = "5";
            output = "DP-3";
          }
          {
            workspace = "6";
            output = "eDP-1";
          }
          {
            workspace = "7";
            output = "eDP-1";
          }
          {
            workspace = "8";
            output = "eDP-1";
          }
          {
            workspace = "9";
            output = "eDP-1";
          }
          {
            workspace = "10";
            output = "eDP-1";
          }
        ];
        bars = [
          (
            {
              mode = "dock";
              hiddenState = "hide";
              position = "top";
              workspaceButtons = true;
              workspaceNumbers = true;
              statusCommand = "${pkgs.i3status}/bin/i3status";
              fonts = {
                names = [ "monospace" ];
                size = 8.0;
              };
              trayOutput = "*";
            }
            // config.stylix.targets.sway.exportedBarConfig
          )
        ];
      };
    };
 
}
