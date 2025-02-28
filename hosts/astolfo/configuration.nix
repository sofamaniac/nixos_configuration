{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Framework specific settings
  
  # Handle BIOS updates
  services.fwupd.enable = true;

  # Add support for fingerprint reader
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.type = "simple";
  };
  services.fprintd.enable = true;

  # Power management
  # the wiki indicates that for AMD Framework laptop, power-profiles-daemon should be preferred over tlp
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  powerManagement.powertop.enable = true;

  # WIFI stability issues
  hardware.enableRedistributableFirmware = true;


  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-label/NIXOS";
}
