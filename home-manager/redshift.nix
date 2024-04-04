{config, osConfig, ...}: {
	osConfig.services.geoclue2.enable = true;
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
}
