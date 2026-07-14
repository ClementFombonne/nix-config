{ self, ... }: {
  flake.nixosModules.zsh = { ... }: {
    programs.zsh.enable = true;
    imports = [ self.nixosModules.oh-my-posh ];

    home-manager.users.clement.imports = [ self.homeModules.zsh ];
  };

  flake.homeModules.zsh = { ... }: {
    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "fino";
        plugins = [
          "git"
          "sudo"
          "copyfile"
        ];
      };
    };
  };
}
