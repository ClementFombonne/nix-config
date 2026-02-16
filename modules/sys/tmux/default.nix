{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.tmux;
in
{
  options.modules.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      shortcut = "q";
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;

      # NixOS plugins must be a list of packages only
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        catppuccin
        yank
      ];

      # Move the plugin-specific config here instead
      extraConfig = ''
        # Catppuccin Theme Settings
        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_window_status_style "rounded"

        # Better splitting keys
        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -v -c "#{pane_current_path}"

        # Vim-style pane resizing
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5
      '';
    };
  };
}
