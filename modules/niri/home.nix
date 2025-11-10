{config, ...}: {
  programs.niri.settings = {
    screenshot-path = "~/screenshots/%Y-%m-%d_%H-%M-%S.png";
    prefer-no-csd = true;

    spawn-at-startup = [
      {argv = ["quickshell"];}
    ];

    overview = {
      backdrop-color = "#11111b";
      workspace-shadow.enable = false;
    };

    hotkey-overlay.skip-at-startup = true;
    clipboard.disable-primary = true;
    binds = with config.lib.niri.actions; {
      "Mod+C".action = spawn "kitty";
      "Mod+R".action = spawn "fuzzel";
      "Mod+Q".action = close-window;

      "XF86AudioMute".action = spawn ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioLowerVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" "-l" "1"];
      "XF86AudioRaiseVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "-l" "1"];
      "XF86MonBrightnessDown".action = spawn ["brightnessctl" "s" "5%-"];
      "XF86MonBrightnessUp".action = spawn ["brightnessctl" "s" "5%+"];

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-workspace-up;
      "Mod+Down".action = focus-workspace-down;

      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;

      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;

      "Mod+W".action = switch-preset-column-width;
      "Mod+P".action = toggle-window-floating;

      "Print".action.screenshot-screen.show-pointer = false;
      "Ctrl+Print".action.screenshot.show-pointer = false;
      "Alt+Print".action.screenshot-window = {};

      "Mod+Shift+E".action = quit {skip-confirmation = true;};
    };

    input = {
      focus-follows-mouse.enable = true;
      touchpad.click-method = "clickfinger";
    };

    layout = {
      background-color = "#181825";
      focus-ring = {
        active.gradient = {
          from = "#5bcefa";
          to = "#f5a9b8";
          angle = 135;
          relative-to = "workspace-view";
        };
        inactive.color = "#585b70";
        urgent.gradient = {
          from = "#f38ba8";
          to = "#fab387";
          angle = 135;
          relative-to = "workspace-view";
        };
      };

      insert-hint.enable = true;

      preset-column-widths = [
        {proportion = 0.5;}
        {proportion = 1.0;}
      ];
      default-column-width.proportion = 1.0;
    };

    window-rules = [
      {
        matches = [
          {
            app-id = "steam";
            title = "^notificationtoasts_\\d+_desktop$";
          }
        ];
        default-floating-position = {
          x = 10;
          y = 10;
          relative-to = "bottom-right";
        };
      }
    ];
  };
}
