{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # touchpad configuration
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      clickMethod = "buttonareas";
    };
  };

  # autologin
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "sofamaniac";
    };
    defaultSession = lib.mkDefault "none+i3";
  };

  networking.hostName = "astolfo"; # Define your hostname.

  # Handle BIOS updates
  services.fwupd.enable = true;

  # Add support for fingerprint reader
  systemd.services.fprintd= {
      wantedBy = ["multi-user.target"];
      serviceConfig.type = "simple";
  };
  services.fprintd.enable = true;

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = ["nodev"];
      efiSupport = true;
      enable = true;
      catppuccin.enable = true;
    };
  };
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-label/NIXOS";

}
