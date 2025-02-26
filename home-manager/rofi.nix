{...}: {
  catppuccin.rofi.enable = true;
  programs.rofi = {
    enable = true;
    terminal = "kitty";
    font = "Hack Nerd Font Mono 14";
    extraConfig = {
      modi = "run,drun,ssh";
      show = "drun";
      scroll-method = 0;
      drun-match-fields = "all";
      drun-display-format = "{name}";
      no-drun-show-action = true;
      kb-cancel = "Escape";
    };
  };
}
