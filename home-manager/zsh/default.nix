{
  config,
  pkgs,
	lib,
  ...
}: {

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
			plugins = [ "colored-man-pages" ];
    };

    initExtra = ''
      fastfetch
      #[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

			# adding cargo bin to PATH
			export PATH="$PATH:/home/sofamaniac/.cargo/bin"

      # direnv setup
      eval "$(direnv hook zsh)"

			# startship
			# eval "$(starship init zsh)"
    '';

    /* plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ]; */
    shellAliases = {
      update = "sudo nixos-rebuild switch";
			pdf = "zathura";
    };
  };
}
