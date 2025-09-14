{...}:{
  wayland.windowManager.hyprland.settings.bind = 
    [
        "$mod, F, exec, firefox"
        "$mod, T, exec, kitty"
        "$mod, C, exec, code"
        "$mod, Q, killactive"
        ", Print, exec, grimblast copy area"
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