{
  # Adds git related signs to the gutter, as well as utilities for managing changes
  # See `:help gitsigns` to understand what the configuration keys do
  # https://nix-community.github.io/nixvim/plugins/gitsigns/index.html
  plugins.remote-nvim = {
    enable = true;
    settings = {
      offline_mode = {
        enabled = true;
        no_github = true;
      };
    };
  };
}
