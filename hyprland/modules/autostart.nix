{ pkgs, ... }: {

  # services.swww.enable = true;
  # systemd.user.services.swww-daemon = {
  #   Unit = {
  #     Description = "swww wallpaper daemon";
  #     After = [ "graphical-session.target" "hyprland-session.target" ]; # Wait for Hyprland
  #     Requires = [ "graphical-session.target" ];
  #     PartOf = [ "graphical-session.target" ];
  #   };

  #   Service = {
  #     ExecStart = "${pkgs.swww}/bin/swww-daemon";
  #     Restart = "on-failure";
  #     RestartSec = 3; # Wait 3 seconds before restarting
  #     # Environment = "WAYLAND_DISPLAY=wayland-1"; # Uncomment and adjust if needed
  #   };

  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  
  # systemd.user.services.ghostty = {
  #   Unit = {
  #     Description = "Ghostty terminal emulator";
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.ghostty}/bin/ghostty";
  #     Restart = "always";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };


  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
    "hypridle"
    # enable after starting quickshell
    # "quickshell" 
  ];
}