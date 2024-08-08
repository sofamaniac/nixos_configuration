{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    catppuccin.enable = true;
    sensibleOnTop = true;
    prefix = "M-Space"; # Alt+Space
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g @plugin 'christoomey/vim-tmux-navigator'

      # Fixing colors
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind c split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind t new-window -c "#{pane_current_path}"
    '';
  };
}
