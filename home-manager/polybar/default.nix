{
  config,
  pkgs,
  dotfiles,
  ...
}: {
  # Totally broken for now :(
  /*
     services.polybar = {
  	enable = true;
  	config = ./config/config.ini;
  	script = "polybar --reload example &";
  catppuccin.enable = true;
  };
  */
  home.packages = [pkgs.polybarFull];

  xdg.configFile = {
    polybar = {
      source = "${dotfiles}/config/polybar";
      # onChange = "pkill polybar; ~/.config/polybar/launch_polybar.sh";
    };
  };
}
