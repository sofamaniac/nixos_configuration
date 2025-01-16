{config, sops, ...}: {
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/sofamaniac/.config/sops/age/keys.txt";
  sops.secrets.password = {
    neededForUsers = true;
  };
}
