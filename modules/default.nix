{
  pkgs,
  inputs,
  config,
  ...
}: {
  # Enabling flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    ./keyboard.nix
    ./locales.nix
    ./xorg.nix
    ./virtualization.nix
    ./docker.nix
    ./fonts.nix
    ./flatpak.nix
    ./network.nix
    ./secrets.nix
  ];

  # using latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Enable catppuccin
  catppuccin.flavor = "macchiato";
  catppuccin.tty.enable = true;

  # enable auto updates
  system.autoUpgrade = {
    enable = true;
    dates = "14:00";
    randomizedDelaySec = "45min";
  };

  # optimize nix store size
  nix.optimise.automatic = true;
  # automatically trigger garbage collection if less than 20GiB of available space in /nix/store
  nix.settings.min-free = 20*1024*1024;

  # Enabel polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable steam
  nixpkgs.config.allowUnfree = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.udisks2.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper];

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sofamaniac = {
    isNormalUser = true;
    description = "sofamaniac";
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = ["networkmanager" "wheel" "uinput" "input"];
    openssh.authorizedKeys.keyFiles = [ ../id_rsa.pub ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # these are basically packages that should be available to root
    # and one should log in as root only if something has gone terribly wrong
    tree
    git
    fzf
    ripgrep
    fd
    btop
    python3
    wget
    neovim
    pciutils
    sops
    # Add man pages
    man-pages
    man-pages-posix
  ];

  # Enabling zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Setting up nh
  programs.nh = {
    enable = true;
    flake = "/home/sofamaniac/nixos_configuration";
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 10";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
