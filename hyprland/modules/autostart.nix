{ pkgs, ... }: {

  services.swww.enable = true;
  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      Environment = "PATH=${pkgs.swww}/bin";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  # programs.quickshell.systemd.enable = true;
  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
    "hypridle"
    "quickshell"
  ];
}