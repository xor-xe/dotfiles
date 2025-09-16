{config, ...}:{
  # GPU stuff
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ]; #thise might work but needs bigger /boot
  # boot.initrd.kernelModules = [  ];
  boot.kernelModules = [ "amdgpu" "nvidia" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  services.xserver.videoDrivers = [ "nvidia" ]; # whne runnig gpu heavy tasks you need specify to us gpu with prime offload if arg is only amgpu cuz now "nvidia" is disabled in wm
  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true; # recommended
    powerManagement.enable = true; # optional, saves power on laptops
    open = false; # for RTX / GTX 16xx and newer

    nvidiaSettings = true;

    prime = {
      offload.enable = true;
      amdgpuBusId = "0000:197:0:0"; # fom my amd igpu i had to find out that it was working by running glxinfo | grep "OpenGL renderer" and the finding out the address with sudo dmesg | grep -i amdgpu
      nvidiaBusId = "0000:196:0:0";
    };
  };
}