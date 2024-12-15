{pkgs, ...}: {
  services.flatpak.enable = true;
  # Automatically setup flatpak repository for all users
  # https://nixos.wiki/wiki/Flatpak
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}

