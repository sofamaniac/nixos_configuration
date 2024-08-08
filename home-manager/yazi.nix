{
  config,
  pkgs,
  ...
}: {
  # required by catppuccin
  xdg.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;
  };
}
