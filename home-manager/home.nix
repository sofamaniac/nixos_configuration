{
  pkgs,
  dotfiles,
  ...
}: {
  imports = [
    ./picom
    ./zsh
    ./kitty
    ./firefox
    ./dunst
    ./polybar
    ./zathura
    ./yama.nix
    ./rofi.nix
    ./gtk.nix
    ./yazi.nix
    ./tmux.nix
    ./starship.nix
    ./nvim.nix
  ];

  catppuccin = {
    flavor = "macchiato";
    cursors = {
      enable = true;
      accent = "rosewater";
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sofamaniac";
  home.homeDirectory = "/home/sofamaniac";

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  catppuccin.fzf.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kmonad
    thunderbird
    discord

    obsidian
    zotero
    pandoc

    wineWowPackages.stable # wine with 32 and 64 bits support
    ruffle

    playerctl
    jq
    wget
    unzip
    unrar
    texliveFull

    lldb
    gdb
    xxd

    # Nice utilities
    eza
    dust
    lazygit
    tldr

    rustdesk-flutter

    eww

    libreoffice
  ];
  programs.bat = {
    enable = true;
  };
  catppuccin.bat.enable = true;
  programs.btop = {
    enable = true;
  };
  catppuccin.btop.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    "scripts".source = "${dotfiles}/scripts";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = ["$HOME/bin"];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.unclutter = {
    enable = true;
  };
  services.network-manager-applet.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.syncthing.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
