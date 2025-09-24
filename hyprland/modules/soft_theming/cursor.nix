{config, pkgs, ...}:{

  

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true; # Enables the theme for GTK applications
    x11.enable = true; # Enables the theme for X11 applications
  };

  wayland.windowManager.hyprland.settings.env = [
    "HYPRCURSOR_THEME, Bibata-Modern-Ice"
    "HYPRCURSOR_SIZE, 24"
  ];
}