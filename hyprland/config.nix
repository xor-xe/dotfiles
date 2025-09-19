{...}: {
  imports = [
    ./modules/input.nix
    ./modules/bind.nix
    ./modules/autostart.nix
    ./modules/waybar.nix
    ./modules/hypridle.nix
    ./modules/hyprlock.nix
    ./modules/quickshell/quickshell.nix
    ./modules/shell/sh.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;


    settings = {
      "$mod" = "SUPER";
       decoration = {
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          new_optimizations = true; # Better performance :cite[3]
        };
        dim_inactive = false;
        active_opacity = 0.8;
        inactive_opacity = 0.7;
        fullscreen_opacity = 1.0;
      };

       windowrulev2 = [
        "opacity 0.95 override 0.95 override,class:^(firefox)$"
        "opacity 0.95 override 0.95 override,class:^(code)$"
        "opacity 0.95 override 0.95 override,class:^(obsidian)$"
        "opacity 0.7 override 0.7 override,class:^(ghostty)$"
        "opacity 0.9 0.7,floating:1"
        # "noblur,class:^(firefox)$"
      ];

    };
  };
}