{config, ...}: {
  programs.niri = {
    enable = true;
    settings = {
      #INPUT DEVICE CONFIGURATION
      input = {
        keyboard = {
          xkb = {
            layout = "us";
          };
          repeat-delay = 600;
          repeat-rate = 25;
        };

        touchpad = {
          tap = {};
          natural-scroll = {};
          dwt = {};
          dwtp = {};
          accel-speed = 0.0;
          middle-emulation = {};
        };

        mouse = {
          accel-speed = 0.0;
        };
      };

      #MONITOR CONFIGURATION
      outputs."eDP-1" = {
        mode = "1920x1080@120";
      };

      prefer-no-csd = {};

      #GUESTURES
      gestures = {
        hot-corners = {
          off = {};
        };
      };

      #CURSOR
      cursor = {
        xcursor-theme = "BreezeX-RosePine-Linux";
        xcursor-size = 30;
      };

      #ENVIRONMENT CONFIGURATION
      environment = {
        DISPLAY = ":0";
      };

      #WORKSPACE SHADOW IN toggle-overview
      overview = {
        zoom = 0.3;
        workspace-shadow = {
          off = {};
        };
      };

      #LAYOUT
      layout = {
        gaps = 10;
        center-focused-column = "never";
        default-column-width = {
          proportion = 0.5;
        };

        preset-column-widths = [
          {proportion = 0.66667;}
          {proportion = 0.5;}
        ];

        focus-ring = {
          width = 2;
          active-color = "#33ccff";
          inactive-color = "#595959";
        };

        border = {
          width = 2;
          active-color = "#33ccff";
          inactive-color = "#595959";
        };
        default-column-display = "normal";
      };

      #AUTOSTART OF APPLICATIONS
      spawn-at-startup = [
        {command = ["bash" "-c" "wl-paste --type text --watch cliphist store &"];}
        {command = ["bash" "-c" "wl-paste --type image --watch cliphist store &"];}
        {command = ["bash" "-c" "wl-paste --type text --watch ~/.config/quickshell/inir/scripts/clipboard-store.py &"];}
        {command = ["zen-beta"];}
        # { command = [ "noctalia-shell" ]; }
        # { command = [ "noctalia" ]; }
      ];

      hotkey-overlay = {
        skip-at-startup = {};
      };

      #SCREENSHOT PATH
      screenshot-path = "~/Pictures/Screenshots/screenshot from %d-%m-%Y-%H-%M-%S.png";

      #ANIMATIONS
      animations = {
        slowdown = 1.0;

        window-open = {
          duration-ms = 400;
          curve = "ease-out-expo";
        };

        window-close = {
          duration-ms = 333;
          curve = "ease-out-expo";
        };

        window-resize = {
          duration-ms = 400;
          curve = "ease-out-expo";
        };

        workspace-switch = {
          duration-ms = 333;
          curve = "ease-out-cubic";
        };

        horizontal-view-movement = {
          duration-ms = 333;
          curve = "ease-out-cubic";
        };

        config-notification-open-close = {
          duration-ms = 250;
          curve = "ease-out-quad";
        };
      };

      #WINDOW RULE
      window-rules = [
        {
          draw-border-with-background = false;
          match = [{app-id = "zen-beta";}];
          opacity = 0.95;
        }
        {
          open-maximized = true;
          match = [{app-id = "zen-beta";}];
        }
        {
          open-maximized = true;
          match = [{app-id = "obsidian";}];
        }
        {
          open-maximized = true;
          match = [{app-id = "zed";}];
        }
        {
          open-maximized = true;
          match = [{app-id = "spotify";}];
        }
        {
          open-maximized = true;
          match = [{app-id = "vesktop";}];
        }
      ];

      #Wallpaper in overview
      layer-rules = [
        {
          match = [{namespace = "^noctalia-backdrop";}];
          place-within-backdrop = true;
        }
        {
          match = [{namespace = "quickshell:iiBackdrop";}];
          place-within-backdrop = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        # #Noctalia-shell binds
        # #Recorder
        # "Mod+Shift+R".action = spawn-sh "noctalia-shell ipc call plugin:screen-recorder toggle";
        #
        # #Search bar
        # "Mod+Space".action = spawn-sh "noctalia-shell ipc call launcher toggle";
        #
        # #Cheat sheet
        # "Mod+Ctrl+C".action = spawn-sh "noctalia-shell ipc call plugin:keybind-cheatsheet toggle";
        #
        # #Clipboard
        # "Ctrl+Shift+L".action = spawn-sh "noctalia-shell ipc call launcher clipboard";
        #
        # # Session menu (has poweroff, reboot, logout, etc.)
        # "Mod+Shift+P".action = spawn-sh "noctalia-shell ipc call sessionMenu toggle";
        #
        # # Lock screen directly
        # "Mod+Shift+L".action = spawn-sh "noctalia-shell ipc call lockScreen lock";

        #Noctalia binds
        # #Search bar
        # "Mod+Space".action = spawn-sh "noctalia msg panel-toggle launcher";
        #
        # #Clipboard
        # "Ctrl+Shift+L".action = spawn-sh "noctalia msg panel-toggle clipboard";
        #
        # # Session menu (has poweroff, reboot, logout, etc.)
        # "Mod+Shift+P".action = spawn-sh "noctalia msg panel-toggle session";
        #
        # # Lock screen directly
        # "Mod+Shift+L".action = spawn-sh "noctalia msg session lock";

        #iNiR binds
        "Ctrl+Shift+L".action = spawn "inir" "clipboard" "toggle";
        "Mod+D".action = spawn "inir" "dashboard" "toggle";
        "Mod+Comma".action = spawn "inir" "settings";
        "Mod+Slash".action = spawn "inir" "cheatsheet" "toggle";
        "Mod+Space".action = spawn "inir" "overview" "toggle";
        "Mod+Shift+R".action = spawn "inir" "region" "record";
        "Mod+Shift+P".action = spawn "inir" "session" "toggle";

        #Lock screen
        "Mod+Shift+L".action = spawn "qylock-lock";

        #Screenshot(in-built in niri)
        "Mod+S".action = screenshot;
        "Mod+Shift+S".action = screenshot-window;
        "Print".action = screenshot;
        "Alt+Print".action = screenshot-window;

        # Applications
        "Mod+E".action = spawn "nautilus";
        "Mod+Return".action = spawn "kitty";
        "Mod+B".action = spawn "zen-beta";

        #Keybind showcase
        "Mod+Tab".action = show-hotkey-overlay;

        #Volume Key bind
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        # Example media keys mapping using playerctl.
        # This will work with any MPRIS-enabled media player.
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action = spawn-sh "playerctl play-pause";
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          action = spawn-sh "playerctl stop";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action = spawn-sh "playerctl previous";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action = spawn-sh "playerctl next";
        };

        #brightness
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
        };

        "Mod+O" = {
          repeat = false;
          action = toggle-overview;
        };

        "Mod+Q" = {
          repeat = false;
          action = close-window;
        };

        "Mod+Page_Down".action = focus-window-down;
        "Mod+Page_Up".action = focus-window-up;
        "Mod+Shift+Down".action = focus-window-down;
        "Mod+Shift+Up".action = focus-window-up;
        "Mod+Shift+J".action = focus-window-down;
        "Mod+Shift+K".action = focus-window-up;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+C".action = focus-column-left;
        "Mod+V".action = focus-column-right;

        "Mod+Down".action = focus-workspace-down;
        "Mod+Up".action = focus-workspace-up;
        "Mod+X".action = focus-workspace-down;
        "Mod+W".action = focus-workspace-up;
        "Mod+J".action = focus-workspace-down;
        "Mod+K".action = focus-workspace-up;

        #Moving windows to workspaces
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;
        "Mod+Shift+0".action = move-column-to-workspace 10;

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-down;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-up;
        };

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        # Usually scrolling up and down with Shift in applications results in
        # horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Ctrl+1".action = move-column-to-workspace 1;
        "Mod+Ctrl+2".action = move-column-to-workspace 2;
        "Mod+Ctrl+3".action = move-column-to-workspace 3;
        "Mod+Ctrl+4".action = move-column-to-workspace 4;
        "Mod+Ctrl+5".action = move-column-to-workspace 5;
        "Mod+Ctrl+6".action = move-column-to-workspace 6;
        "Mod+Ctrl+7".action = move-column-to-workspace 7;
        "Mod+Ctrl+8".action = move-column-to-workspace 8;
        "Mod+Ctrl+9".action = move-column-to-workspace 9;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        # Cycle through widths set in preset-column-widths.
        "Mod+R".action = switch-preset-column-width;

        "Mod+Ctrl+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;

        "Mod+Shift+F".action = maximize-column;
        "Mod+F".action = fullscreen-window;

        "Mod+M".action = maximize-window-to-edges;

        #Setting column height
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        #Setting window height(makes it finer when with other windows on top)
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        # Move the focused window between the floating and the tiling layout.
        "Mod+Z".action = toggle-window-floating;
        "Alt+Z".action = switch-focus-between-floating-and-tiling;

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Ctrl+Alt+Delete".action = quit;
      };

      includes = ["./Effects/pop-drop.kdl"];
    };
  };
}
