{pkgs, ...}:{
  # Power management stuff
  services.power-profiles-daemon.enable = true;

  # power limmiter script
  # /etc/nixos/configuration.nix
  systemd.services.battery-charge-threshold = {
    description = "Set battery charge stop threshold";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };
}