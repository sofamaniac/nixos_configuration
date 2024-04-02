{config, specialArgs, ...}: {
	# /!\ Requires global service geoclue2 /!\
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
}
