{
  config,
  pkgs,
  dotfiles,
  ...
}: {
  # Cannot be setup to use a folder for the configuration
  /*
  services.polybar = {
  	enable = true;
  	config = "~/.config/polybar/config.ini";
  	script = "polybar --reload example &";
    package = pkgs.polybarFull;
    # catppuccin.enable = true;
  };
  */

  home.packages = [pkgs.polybarFull];
  xdg.configFile = {
    polybar = {
      source = "${dotfiles}/config/polybar";
      onChange = "pkill polybar; ~/.config/polybar/launch_polybar.sh";
    };
  };
}
