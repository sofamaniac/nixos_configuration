{lib, ...}: {
  imports = [
    ./configuration.nix
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
  networking.hostName = "astolfo"; # Define your hostname.
  # autologin
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "sofamaniac";
    };
    defaultSession = lib.mkDefault "none+i3";
  };
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
    };
  };
  catppuccin.grub.enable = true;
}
