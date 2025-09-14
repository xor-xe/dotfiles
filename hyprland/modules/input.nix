{ ... }: {
  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "us,ge";
    follow_mouse = 1;
    touchpad.natural_scroll = true;

    kb_options = "grp:win_space_toggle";
  };
}
