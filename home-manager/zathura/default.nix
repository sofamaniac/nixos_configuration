{
  config,
  pkgs,
	dotfiles,
  ...
}: {
  programs.zathura.enable = true;

	xdg.configFile = {
		zathura = {
			# source = ../../dotfiles/config/zathura;
			source = "${dotfiles}/config/zathura";
		};
	};
}
