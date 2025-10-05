{...}: {
  # Display Manager - ly
  services.displayManager.ly.enable = true;
  
  services.displayManager.ly.settings = {
    animation =  "matrix";
    bigclock = true;
    bigclock_12hr = true;
  };
}