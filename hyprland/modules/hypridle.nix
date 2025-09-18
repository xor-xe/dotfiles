{...}:{
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
    after_sleep_cmd = "hyprctl dispatch dpms on";
    ignore_dbus_inhibit = false;
    lock_cmd = "hyprlock";
  };

  listener = [
    {
      timeout = 150;
      on-timeout = "brightnessctl -s set 15";
      on-resume = "brightnessctl -r";
    }
    { 
      timeout = 150;
      on-timeout = "brightnessctl -sd asus::kbd_backlight set 0";
      on-resume = "brightnessctl -rd asus::kbd_backlight";
    }
    {
      timeout = 900;
      on-timeout = "hyprlock";
    }
    {
      timeout = 1200;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on";
    }
    {
      timeout = 1800;
      on-timeout = "systemctl suspend";
    }
    
  ];
  };
}