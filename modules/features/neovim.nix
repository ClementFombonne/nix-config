{ self, inputs, ... }: {
  flake.nixosModules.neovim = { pkgs, ... }: {
    imports = [
      self.nixosModules.development
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };

    home-manager.users.clement.imports = [ self.homeModules.neovim ];
  };

  flake.homeModules.neovim = { pkgs, config, ... }: {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      withPython3 = false;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        mini-nvim
        nvim-treesitter.withAllGrammars
        blink-cmp
        snacks-nvim
        noice-nvim
        conform-nvim
        lazygit-nvim
      ];
      sideloadInitLua = true;
    };

    xdg.configFile."nvim".source = inputs.neovim-config;
  };
}
