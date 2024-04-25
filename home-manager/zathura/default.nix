{
  config,
  pkgs,
  ...
}: {
  programs.zathura.enable = true;

	xdg.configFile = {
		zathura = {
			source = ../../dotfiles/config/zathura;
		};
	};
}
