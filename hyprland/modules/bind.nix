{...}:{

  wayland.windowManager.hyprland.settings.gestures = {
    workspace_swipe = true;
    workspace_swipe_fingers = 3;  # Number of fingers for swipe
    workspace_swipe_distance = 300;  # Minimum distance in pixels
    workspace_swipe_invert = true;  # Default direction
    workspace_swipe_min_speed_to_force = 5;  # Minimum speed to force switch
    workspace_swipe_cancel_ratio = 0.5;  # Fraction to cancel swipe
  };
  wayland.windowManager.hyprland.settings.bind = 
    [   # generic
        "$mod, Q, killactive"

        # apps
        "$mod, F, exec, firefox"
        "$mod, T, exec, ghostty --command='zsh' "
        "$mod, C, exec, cursor"
        "$mod, R, exec, wofi --show drun"

        # sound mod
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # brightness
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86KbdLightOnOff, exec, ~/.config/scripts/keyboard_lights.sh"

        # mic switch
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # misc
        ", Print, exec, grimblast copy area"
        "$mod ALT, F1, exec, powerprofilesctl set power-saver"    # Switch to power-saver
        "$mod ALT, F2, exec, powerprofilesctl set balanced"       # Switch to balanced
        "$mod ALT, F3, exec, powerprofilesctl set performance"    # Switch to performance

        # XF86Assistant - AI key 
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
    );
  

  wayland.windowManager.hyprland.settings.bindm = 
  [
    # mouse movements
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
    "$mod ALT, mouse:272, resizewindow"
  ];

}