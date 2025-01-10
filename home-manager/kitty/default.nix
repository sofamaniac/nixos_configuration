{
  config,
  pkgs,
  nix-colors,
  ...
}: {
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };
  catppuccin.kitty.enable = true;
}
