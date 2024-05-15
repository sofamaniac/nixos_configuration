{
  config,
  pkgs,
  inputs,
  nikspkg,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
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
      };
    };
  };

  # Configure console keymap
  # use same config as xserver
  console.useXkbConfig = true;
}
