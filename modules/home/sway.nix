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

      config = {
        modifier = "Mod4";
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
          };
        output = {
          "HDMI-A-1" = {
            pos = "3024 0";
          };
        };
        bars = [
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
            colors = {
              background = "#000000";
              statusline = "#ffffff";
              separator = "#666666";
              focusedWorkspace = {
                border = "#4c7899";
                background = "#285577";
                text = "#ffffff";
              };
              activeWorkspace = {
                border = "#333333";
                background = "#5f676a";
                text = "#ffffff";
              };
              inactiveWorkspace = {
                border = "#333333";
                background = "#222222";
                text = "#888888";
              };
              urgentWorkspace = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
              bindingMode = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
            };
          }
        ];
      };
    };
 
}
