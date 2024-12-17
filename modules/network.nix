{...}: {
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Tailscale configuration
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client"; # required to use exit node cf wiki for more info
  };
}
