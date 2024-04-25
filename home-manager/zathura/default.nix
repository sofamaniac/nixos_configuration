{
  config,
  pkgs,
  ...
}: {
  programs.zathura.enable = true;

	xdg.configFile = {
		zathura = {
			source = ./config;
		};
	};
}
