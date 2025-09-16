{pkgs, ...}:{
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = false;

  # Enable GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # important for EFI
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.gfxmodeEfi = "2880x1800";   # replace with your resolution
  boot.loader.grub.gfxpayloadEfi = "keep";
  boot.loader.grub.theme = "${pkgs.fetchFromGitHub { # current as of 11/2022
    owner = "adnksharp";
    repo = "CyberGRUB-2077";
    rev = "2e34b5f9c5812f1af274bc652b2c31f893015ca1";
    sha256 = "sha256-R/rQgwsA61dZrPr2OQt5bnI/QZXKLUB8xIoDJga1VoU=";
  }}/CyberGRUB-2077";
  boot.loader.grub.extraEntries = ''
    menuentry "Windows Boot Manager (on /dev/nvme0n1p1)" {
        insmod part_gpt
        insmod fat
        search --no-floppy --fs-uuid --set=root 3C9B-F75D
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';

  # Allow GRUB to find Windows and other OS
  boot.loader.grub.useOSProber = true;
}