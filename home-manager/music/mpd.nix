{
	config,
	pkgs,
	...
}:{
	
	services.mpd = {
		enable = true;
		musicDirectory = "~/Musics";
		dbFile = "~/.mpd_db";
	};
	services.mpd-mpris = {
		enable = true;
		mpd.useLocal = true;
	};

	programs.ncmpcpp.enable = true;

	services.mopidy = {
		enable = true;
		extensionPackages = with pkgs; [ mopidy-mpd mopidy-youtube ];
	};
}
