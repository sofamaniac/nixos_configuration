{
  config,
  pkgs,
  inputs,
  ...
}: {

  # Enabling virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.sofamaniac.extraGroups = [ "libvirtd"];

}
