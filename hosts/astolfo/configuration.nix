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
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/72e56314-4e78-48ac-9777-d2a4998b4b5f";

  ## === Battery charging === ##
  powerManagement.enable = true;
  services.tlp.enable = true;
  ## ======================== ##

  # Setting up hardware acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver
}
