{
  config,
  pkgs,
  inputs,
  ...
}:
  ## === DOCKER === ##

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["sofamaniac"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  ## ============== ##
}
