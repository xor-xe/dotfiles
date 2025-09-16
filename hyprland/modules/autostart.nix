{ ... }: {
  services.swww.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  # programs.quickshell.systemd.enable = true;
  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];
}