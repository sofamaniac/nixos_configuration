{pkgs, ...}: {
  imports = [./redshift.nix];
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "fr";
      variant = "";
    };
    # Enabling i3
    windowManager = {
      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi
          polybarFull
          jgmenu
          picom
          feh
          xdotool
          autotiling
        ];
      };
    };
  };
  # i3 does not provide a tray
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    description = "Home Manager System Tray";
    requires = ["graphical-session-pre.target"];
  };
  # Configuring sddm
  services.displayManager = {
    sddm = {
      enable = true;
      # we need to change the package in order for the theme to work
      # see https://github.com/NixOS/nixpkgs/issues/292761
      package = pkgs.kdePackages.sddm;
    };
  };
  catppuccin.sddm.enable = true;
  
  # adding autorandr for automatic display detection
  services.autorandr.enable = true;

}
