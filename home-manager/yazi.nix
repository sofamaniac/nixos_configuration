{...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  catppuccin.yazi.enable = true;
  # required by catppuccin
  xdg.enable = true;
}
