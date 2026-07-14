{ self, ... }: {
  flake.nixosModules.tmux = { pkgs, ... }: {
    programs.tmux = {
      enable = true;
      clock24 = true;
      shortcut = "q";
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        catppuccin
        yank
      ];

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

    home-manager.users.clement.imports = [ self.homeModules.tmux ];
  };

  flake.homeModules.tmux = { ... }: {
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
