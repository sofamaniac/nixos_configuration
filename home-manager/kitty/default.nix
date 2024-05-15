{
  config,
  pkgs,
  nix-colors,
  ...
}: {

  programs.kitty = {
    enable = true;
		catppuccin.enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };
}
