{
  config,
  pkgs,
  ...
}: {
	# Totally broken for now :(
	/* services.polybar = {
		enable = true;
		config = ./config/config.ini;
		script = "polybar --reload example &";
	}; */
	home.packages = [ pkgs.polybarFull ];

	xdg.configFile = {
		polybar = {
			source = ./config;
			# onChange = "pkill polybar; ~/.config/polybar/launch_polybar.sh";
		};
	};
}
