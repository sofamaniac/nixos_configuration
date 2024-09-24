{
  config,
  pkgs,
  ...
}: {
  # Enable neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    # catppuccin.enable = true;
    extraPackages = with pkgs; [
      xclip # clipboard support
      gcc # for treesitter
      ctags
    ];
  };
  home.sessionVariables = {
      # required for marksman because no libicu
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
  };

}
