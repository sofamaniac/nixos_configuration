# does not requires an argument
{_ ? 0}: {
  shadow = true;
  shadow-radius = 12;
  shadow-offset-x = -17;
  shadow-offset-y = -7;
  shadow-opacity = 0.5;
  shadow-exclude = [
    "name = 'Notification'"
    "class_g = 'Dunst'"
    "window_type = 'menu'"
    "window_type = 'dropdown_menu'"
    "window_type = 'popup_menu'"
    "window_type = 'tooltip'"
    "window_type = 'dock'"
  ];

  # does not work well with shadows
  corner-radius = 10;
  rounded-corners-exclude = [
    "window_type = 'dock'"
  ];

  ## opacity
  active-opacity = 0.90;
  inactive-opacity = 0.90;
  frame-opacity = 1.00;
  opacity-rule = [
    # disable transparency in fullscreen mode
    "100:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_FULLSCREEN'"
    "100:_NET_WM_STATE@[1]:32a = '_NET_WM_STATE_FULLSCREEN'"
    "100:_NET_WM_STATE@[2]:32a = '_NET_WM_STATE_FULLSCREEN'"
    "100:_NET_WM_STATE@[3]:32a = '_NET_WM_STATE_FULLSCREEN'"
    "100:_NET_WM_STATE@[4]:32a = '_NET_WM_STATE_FULLSCREEN'"
    # make tabbed / stacked windows invisible
    "0:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_HIDDEN'"
    "0:_NET_WM_STATE@[1]:32a = '_NET_WM_STATE_HIDDEN'"
    "0:_NET_WM_STATE@[2]:32a = '_NET_WM_STATE_HIDDEN'"
    "0:_NET_WM_STATE@[3]:32a = '_NET_WM_STATE_HIDDEN'"
    "0:_NET_WM_STATE@[4]:32a = '_NET_WM_STATE_HIDDEN'"

    "100:class_g = 'firefox'"
    "100:class_g = 'Dunst'"
    "100:class_g = 'feh'"
    "100:class_g = 'ruffle'"
  ];

  ## other
  backend = "glx";
  mark-wmwin-focused = true;
  mark-ovredir-focused = true;
  detect-rounded-corners = true;
  detect-client-opacity = true;

  vsync = true;

  glx-copy-from-front = true;
  glx-swap-method = 2;
  xrender-sync = true;
  xrender-sync-fence = true;
  unredir-if-possible = false;

  dbe = false;
  # paint-on-overlay = true;
  focus-exclude = [
    "class_g = 'Cairo-clock'"
    "class_g = 'CoverGloobus'"
    "class_g = 'Tilda'"
  ];
  detect-transient = true;
  detect-client-leader = true;
  invert-color-include = [];
  use-damage = true;

  ## blur
  experimental-backends = true;
  blur-background = true;
  blur-background-frame = false;
  blur-background-fixed = false;
  blur-kern = "11x11gaussian";
  blur-method = "dual_kawase";
  blur-strength = 2;
  blur-background-exclude = [
    "window_type = 'dock'"
    "window_type = 'desktop'"
    "class_g = 'Dunst'"
    "window_type = 'menu'"
    "window_type = 'dropdown_menu'"
    "window_type = 'popup_menu'"
    "window_type = 'tooltip'"
  ];

  ## adding fadeout effect for dunst
  fading = true; # Fade windows during opacity changes
  fade-delta = 30; # The time between steps in a fade in milliseconds
  fade-in-step = 0.04; # Opacity change between steps while fading in
  fade-out-step = 0.08; # Opacity change between steps while fading out
  fade-exclude = ["class_g ~= '^(?!.*(Dunst))'"]; # exclude every window except for dunst

  wintypes = {
    dnd = {shadow = false;};
    tooltip = {
      opacity = 1;
      focus = true;
    };
    popup_menu = {
      opacity = 1;
      focus = true;
    };
    dropdown_menu = {
      opacity = 1;
      focus = true;
    };
    menu = {
      opacity = 1;
      focus = true;
    };
  };
}
