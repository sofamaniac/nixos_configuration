{...}: {
  catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 11;
        normal.family = "Iosevka";
      };
      env = {
          # for tmux colors to work properly
          TERM = "xterm-256color";
      };
    };
  };
}
