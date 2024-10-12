{pkgs, ...}: {
  # Add required dependencies for yama
  home.packages = with pkgs; [
    yt-dlp
    openssl
    ffmpeg
  ];
  programs.mpv = {
    enable = true;
    catppuccin.enable = true;
  };
}
