{config, ...}: {
  # location.provider = "geoclue2";
  services.redshift = {
    enable = true;
    temperature = {
      day = 5700;
      night = 3500;
    };
  };
	location = {
		provider = "manual";
		latitude = 49.25;
		longitude = 4.10;
	};
}
