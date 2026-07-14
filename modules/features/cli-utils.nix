{ self, ... }: {
  flake.nixosModules.cli-utils = { pkgs, ... }: {
    imports = [
      self.nixosModules.tmux
      self.nixosModules.zsh
    ];

    environment.systemPackages = with pkgs; [
      # Core utilities
      bat
      eza
      fzf
      ripgrep
      tealdeer
      unzip
    ];

    environment.shellAliases = {
      ls = "eza --icons=auto";
      ll = "eza --icons=auto -l --git --total-size";
      l = "eza --icons=auto -la";
      tree = "eza --icons=auto --tree";
    };

    home-manager.users.clement.imports = [ self.homeModules.cli-utils ];
  };

  flake.homeModules.cli-utils = { ... }: {
    programs.zsh.shellGlobalAliases = {
      ls = "eza --icons=auto";
      ll = "eza --icons=auto -l --git --total-size";
      l = "eza --icons=auto -la";
      tree = "eza --icons=auto --tree";
    };
  };
}
