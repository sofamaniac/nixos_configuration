{config, pkgs, nikpgs, ...}: {
	imports = [ ./redshift.nix ];
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
        ];
      };
    };
  };
  # Configuring sddm
  services.displayManager = {
    sddm = {
      enable = true;
			catppuccin.enable = true;
    };
    # setting custom keymap
    # sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
  };
}
