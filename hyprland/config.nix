{...}: {
  imports = [
    ./modules/input.nix
    ./modules/bind.nix
    ./modules/autostart.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
    "$mod" = "SUPER";
    };
  };
}