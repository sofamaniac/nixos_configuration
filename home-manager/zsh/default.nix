{
  config,
  pkgs,
  lib,
  ...
}: {
	imports = [ ../fastfetch.nix ];

  # adding cargo bin to PATH
  home.sessionPath = ["$HOME/.cargo/bin"];

  # configure zsh
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };

    # Enabling oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = ["colored-man-pages" "tmux"];
    };

    initExtra = ''
      fastfetch

      # direnv setup
      eval "$(direnv hook zsh)"

      # startship
      # eval "$(starship init zsh)"
    '';
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      pdf = "zathura";
    };
  };
}
