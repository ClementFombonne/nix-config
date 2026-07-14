{ self, ... }: {
  flake.nixosModules.oh-my-posh = { ... }: {
    home-manager.users.clement.imports = [ self.homeModules.oh-my-posh ];
  };

  flake.homeModules.oh-my-posh = { ... }: {
    programs.oh-my-posh = {
      enable = true;
      configFile = "$HOME/.config/oh-my-posh/zen.toml";
    };

    xdg.configFile."oh-my-posh/zen.toml".source = ./zen.toml;
  };
}
