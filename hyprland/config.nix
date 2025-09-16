{...}: {
  imports = [
    ./modules/input.nix
    ./modules/bind.nix
    ./modules/autostart.nix
    ./modules/waybar.nix
    ./modules/hypridle.nix
    ./modules/hyprlock.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";
    };
  };
}