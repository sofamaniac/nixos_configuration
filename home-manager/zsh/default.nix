{config, pkgs, ...}: {
  imports = [../fastfetch.nix];

  # adding cargo bin to PATH
  home.sessionPath = ["$HOME/.cargo/bin"];

  catppuccin.zsh-syntax-highlighting.enable = true;

  # configure zsh
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestion = {
        enable = true;
    };

    # Enabling oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = ["colored-man-pages" "tmux" ];
    };

    plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
    ];

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
      ll = "eza -al";
      l = "eza -l";
      lt = "eza -l --tree";
      llt = "eza -al --tree";
    };
  };
}
