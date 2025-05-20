{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Adding devenv cachix
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

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
  networking.networkmanager.wifi.powersave = false;
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
  #networking.networkmanager.wifi.backend = "iwd";


  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-label/NIXOS";
}
