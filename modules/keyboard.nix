{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
    kanata
  ];

  # Setting up keyboard
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
        esc = "capslock";
        f1 = "playpause";
        f2 = "previoussong";
        f3 = "nextsong";
        # rightcontrol = "leftmeta";
      };
    };
  };

  # Configure console keymap
  # use same config as xserver
  console.useXkbConfig = true;
}
