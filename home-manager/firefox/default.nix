{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      sofamaniac = {
        id = 0;
        name = "sofamaniac";
        search = {
          default = "ddg";
          # recommended since Firefox will replace the symlink for the search configuration on every launch
          force = true;
        };
        userChrome = builtins.readFile ./userChrome.css;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          # disable Alt menu
          "ui.key.menuAccessKeyFocuses" = false;
        };
      };
    };
  };
}
