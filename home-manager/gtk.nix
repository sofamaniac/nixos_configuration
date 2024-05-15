{
	config,
	pkgs,
	...
}:{
	# adding dependencies requires for gtk
	# this should maybe be added in nixos config
  # see https://github.com/nix-community/home-manager/issues/3113
	home.packages = [ pkgs.dconf ];
	# required by catppuccin
	xdg.enable = true;
	gtk = {
		enable = true;
		catppuccin.enable = true;
	};
}
