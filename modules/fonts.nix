{pkgs, ...}: {
  # Setting up fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    nerd-fonts.hack
    nerd-fonts.fira-code
    iosevka
  ];
  fonts.fontDir.enable = true;
  # Set default fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Hack Nerd Font"
      "Noto Sans Mono CJK JP"
    ];

    sansSerif = [
      "Noto Sans"
      "Noto Sans CJK JP"
    ];

    serif = [
      "Noto Serif"
      "Noto Serif CJK JP"
    ];
  };
}
