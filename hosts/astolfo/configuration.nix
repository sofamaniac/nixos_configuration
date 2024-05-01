{
  config,
  pkgs,
  inputs,
  nikspkg,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  # cf docs for more info on how it works https://nixos.org/guides/nix-pills/callpackage-design-pattern.html
  callPackage = path: overrides: let
    f = import path;
  in
    f ((builtins.intersectAttrs (builtins.functionArgs f) pkgs) // overrides);
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "astolfo"; # Define your hostname.
	services.printing.enable = true;
	services.printing.drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];

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

	## === Battery charging === ##
  services.tlp = {
    enable = true;
    settings = {
      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging
    };
  };
	## ======================== ##


	## === DOCKER === ##

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["sofamaniac"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

	## ============== ##

  # Setting up hardware acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
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
