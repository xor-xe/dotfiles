{pkgs, config, vars, ...}:{

  home.file.".config/${vars.projectName}/swww/wallpapers".source = ./wallpapers;

  home.file.".config/${vars.projectName}/scripts/swww/swww-init.sh" = {
    text = ''
      #!/bin/bash
      # Wait until a Hyprland instance is running
      until hyprctl monitors > /dev/null 2>&1; do
          sleep 0.1
      done
      # Now initialize your wallpaper
      swww img ~/.config/${vars.projectName}/swww/wallpapers/${vars.defaultWallpaperName}
    '';
    executable = true;
  };
  

  services.swww.enable = true;

  wayland.windowManager.hyprland.settings.exec-once = [
    "swww-daemon && ~/.config/${vars.projectName}/scripts/swww/swww-init.sh"
  ];
}