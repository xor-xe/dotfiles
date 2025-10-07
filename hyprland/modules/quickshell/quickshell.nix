{...}:{

  # it is run from dotfiles for now, but should be changed it to be run from home

  home.file.".config/quickshell/shell.qml".source = ./configs/main.qml;
  home.file.".config/quickshell/notifications/SoundNotification.qml".source = ./configs/notifications/SoundNotification.qml;
  home.file.".config/quickshell/notifications/BrightnessNotification.qml".source = ./configs/notifications/BrightnessNotification.qml;

}